import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { MatDialog } from '@angular/material/dialog';
import { CreateTodoDialogComponent } from '../create-todo-dialog/create-todo-dialog.component';

@Component({
  selector: 'app-home-page',
  templateUrl: './home-page.component.html',
  styleUrls: ['./home-page.component.css'],
})
export class HomePageComponent implements OnInit {
  public todos: any[] = [];

  constructor(public dialog: MatDialog, private http: HttpClient) {}

  ngOnInit(): void {
    this.getTasks();
  }

  getTasks() {
    const token = sessionStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    this.http
      .get(`${environment.apiUrl}/v1/todos`, { headers: headers })
      .subscribe(
        (data: any) => {
          this.todos = data;
        },
        (error) => {
          console.log(error);
        }
      );
  }

  openDialog(): void {
    const dialogRef = this.dialog.open(CreateTodoDialogComponent, {
      width: '300px',
      data: null,
    });

    dialogRef.afterClosed().subscribe((result) => {
      this.addTask(result);
    });
  }

  addTask(todo) {
    const token = sessionStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    this.http
      .post(`${environment.apiUrl}/v1/todos`, todo, { headers: headers })
      .subscribe(
        (data: any) => {
          this.todos.push(todo);
        },
        (error) => {
          console.log(error);
        }
      );
  }
}
