import React, { Component } from 'react';

export class FetchData extends Component {

    static displayName = FetchData.name;

    constructor(props) {
        super(props);
        this.state = { users: [], loading: true };
    }

    componentDidMount() {
        this.populateUserData();
    }

    static DeleteButton(userId) {
        fetch('Users?id=' + userId, { method: 'DELETE' })
            .then(response => response.json())
            .then((result) => {
                alert(result);
                window.location.reload(false);
            }, (userId) => {
                console.log('Failed' + " " + userId);
            })
        window.location.reload(false);
    }

    static handleSubmit = (event, user) => {
        event.preventDefault();
        fetch('Users', {
            method: 'PUT',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                Id: user.id,
                FirstName: user.firstName = event.target.firstName.value,
                LastName: user.lastName = event.target.lastName.value,
                Age: user.age = event.target.age.value,
                EmailAddress: user.emailAddress = event.target.emailAddress.value
            })

        })
            .then(response => response.json())
            .then((result) => {
                alert(result);
                window.location.reload(false);
            }, (userId) => {
                console.log('Failed' + event + " " + user);
            })
        window.location.reload(false);
    };

    static renderUserTable(users) {
        return (
            <table className='table table-striped' aria-labelledby="tabelLabel">
                <thead>
                    <tr>
                        <th>FirstName</th>
                        <th>LastName</th>
                        <th>Age</th>
                        <th>EmailAddress</th>
                    </tr>
                </thead>
                <tbody>
                    {users.map(user =>
                        <tr key={user.id}>
                            <td>{user.firstName}</td>
                            <td>{user.lastName}</td>
                            <td>{user.age}</td>
                            <td>{user.emailAddress}</td>
                            <td>
                                <form onSubmit={(e) => this.handleSubmit(e, user)}>
                                    <input
                                        type="text"
                                        id="firstName"
                                        name="firstName"
                                        placeholder="First Name"
                                    />
                                    <br />
                                    <input
                                        type="text"
                                        id="lastName"
                                        name="lastName"
                                        placeholder="Last Name"
                                    />
                                    <br />
                                    <input
                                        type="text"
                                        id="age"
                                        name="age"
                                        placeholder="Age"
                                    />
                                    <br />
                                    <input
                                        type="text"
                                        id="emailAddress"
                                        name="emailAddress"
                                        placeholder="Email Address"
                                    />
                                    <br />
                                    <button type="submit">Submit</button>
                                </form>                               
                            </td>
                            <td>
                                <button onClick={() => this.DeleteButton(user.id)} className="btn btn-light mr-1" >
                                    Delete Record
                                </button>
                            </td>
                        </tr>
                    )}
                </tbody>
            </table>
        );
    }

    render() {

        let contents = this.state.loading
            ? <p><em>Loading...</em></p>
            : FetchData.renderUserTable(this.state.users)

        return (
            <div>
                <h1 id="tabelLabel" >User Table</h1>
                <p>This component demonstrates fetching data from the server.</p>
                {contents}
            </div>
        );
    }

    async populateUserData() {
        const response = await fetch('Users');
        const data = await response.json();
        this.setState({ users: data, loading: false });
    }
}

