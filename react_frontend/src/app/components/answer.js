import React, { Component } from 'react';
import './answer.css'; 
class Answer extends Component {


    render() {
     
        var txtcolor="green";
        if(this.props.answer=="no")
            txtcolor="red"
        const textColor = {
            //backgroundColor: 'rgb(' + red + ', ' + green + ', 0)', padding: '15px'
            backgroundColor:txtcolor

        };
        return (
            <div>
                <div class="answer" style={textColor}> {this.props.answer}</div>
                <img src={this.props.image} alt={this.props.answer}/>

            </div>);
    }
}
export default Answer;