import { CanActivate, Router } from '@angular/router';
import { Injectable } from '@angular/core';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private router: Router) {}

  canActivate() {
    const token = sessionStorage.getItem('token');
    if (!token) {
      this.router.navigate(['/']);
      return false;
    }

    return true;
  }
}
