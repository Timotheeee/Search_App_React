import React, { Component } from 'react'
import './App.css'
import axios from 'axios'
import {
    Button,
    Navbar,
    NavbarBrand,
    Card,
    CardText,
    Col} from 'reactstrap'
let { useState } = React;

export default class App extends Component {
  render() {
    return (
      <Container>

      </Container>
    )
  }
}

function Container() {


  const [json, setJson] = useState(null);
  const [selected, setSelected] = useState(-1);
  const [search, setSearch] = useState("");

  const onClickView = (index) => {
    setSelected(index);
  };

  return (
    <div className='button__container'>

      {/* main page: */}
        <Navbar color="light" light expand="md">
            <NavbarBrand href="/">GitHub Repository Search</NavbarBrand>
        </Navbar>
        <Col sm={{ size: 6, order: 2, offset: 3 }}>
        <Card body className="text-center">
      <input placeholder="Search for Repositories" value={search} onChange={(e)=>{setSearch(e.target.value)}}/>
      <p>{' '}</p>
      <Button style={{ display: json == null ? "block" : "none" }} color="primary" type="button" className='button' onClick={() => {
        axios.get('https://api.github.com/search/repositories?q=' + search).then(response => setJson(response.data.items))
      }}>Search</Button>
            <p>{' '}</p>
            <p>&copy; Gabriele Pace (<a href="https://github.zhaw.ch/pacegab1">pacegab1</a>) & Timothé Laborie (<a href="https://github.zhaw.ch/labortim">labortim</a>)</p>
            <CardText>MOBA2 <a href="https://github.com/Timotheeee/Search_App_React">Mini Project</a></CardText>
        </Card>
        </Col>
      {/* results: */}
      {json != null && selected === -1 ? <RepoList repos={json} onClickView={onClickView} /> : ""}

      {/* details: */}
      {selected !== -1 ? <RepoDetails repo={json.find(element => element.id === selected)} /> : ""}
      {selected !== -1 ? <Button color="primary" type="button" className='button' onClick={() => { setJson(null); setSelected(-1); setSearch(""); }}>Home</Button> : ""}
    </div>
  );
}


const RepoList = ({
  repos,
  onClickView,
}) => (
  <ul>
    {repos.map(i => (
      <RepoOverview
        key={i.id}
        repo={i}
        onClickView={onClickView}
      />
    ))}
  </ul>
);



const RepoOverview = ({
  repo,
  onClickView,
}) => (
  <li onClick={() => { onClickView(repo.id) }}>
    <h2>
      {repo.name}
    </h2>
    <p>
      {repo.description}
    </p>
  </li>
);


const RepoDetails = ({
  repo,
}) => (
  <div>
    <h2>
      {repo.name}
    </h2>
    <p>{"Description: " + repo.description}</p>
    <p>{"Owner: " + repo.owner.login}</p>
    <img src={repo.owner.avatar_url} alt="avatar"></img>
    <p>{"created at: " + repo.created_at}</p>
    <p>{"forks: " + repo.forks}</p>
  </div>
);
