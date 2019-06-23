import React, { Component } from 'react';
import './App.css'; 
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import TextField from 'material-ui/TextField';
import RaisedButton from 'material-ui/RaisedButton';
import Paper from 'material-ui/Paper';
import Answer from "./app/components/answer";
const style = {
    margin: 0,
    marginTop: 30
};
class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            answer: undefined, forced: undefined, image: undefined
        };
    };
    getAnAnswer() {
        console.log(window.REACT_APP_API_URL);
        fetch(window.REACT_APP_API_URL, {
            method: 'GET', headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => response.json())
            .then(data => this.setState(data));
    }
    onEnterPress = e => {
        if (e.key === 'Enter') {
            this.getAnAnswer();
        }
    };
    render() {
        const answerComponent = this.state.answer !== undefined ?
            <Answer answer={this.state.answer} forced={this.state.forced} image={this.state.image} /> : null;
        const paperStyle = {
            minheight: 300,
            
            width: 700,
            margin: 20,
            textAlign: 'center',
            display: 'inline-block',
        };
        
        return (
            <MuiThemeProvider >
                <div className="centerize">
                    <Paper zDepth={4} style={paperStyle} className="content">
                        <h2>Simply think of a question that requires a yes or no answer, and click below. </h2>
                        <TextField fullWidth={true} ref={ref => this.textField = ref} onKeyUp={this.onEnterPress.bind(this)}
                            hintText="Ask you question." />
                        <RaisedButton fullWidth={true} primary={true} label="Get an answer" style={style} onClick={this.getAnAnswer.bind(this)} />
                       
                        {answerComponent}
                    </Paper>
                </div>
            </MuiThemeProvider>
        );
    }
}
export default App;