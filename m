From: Sage Weil <sage@inktank.com>
Subject: Re: error: could not read lock status
Date: Wed, 3 Oct 2012 09:16:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210030916070.23173@cobra.newdream.net>
References: <CAB0Uiv0-k0zgS5yTj23uXdU8W5t9ejwYVCs+9XhqWC14+PKrWA@mail.gmail.com> <CAPYLRzjKW8ruuDPJaBO4E7Cb3u65zUb3rDZO+Jvn6+asypVTNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34468 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964854Ab2JCQQc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 12:16:32 -0400
In-Reply-To: <CAPYLRzjKW8ruuDPJaBO4E7Cb3u65zUb3rDZO+Jvn6+asypVTNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Pradeep S <pradeeps192@gmail.com>, ceph-devel@vger.kernel.org

On Wed, 3 Oct 2012, Gregory Farnum wrote:
> Check out the thread titled "[ceph-commit] teuthology lock_server error". :)

In case it didn't hit ceph-devel:

Add 

check-locks: false

to your yaml file and the lock checks will all go away.

sage


> 
> On Wed, Oct 3, 2012 at 5:41 AM, Pradeep S <pradeeps192@gmail.com> wrote:
> > hi, i am getting the following error while executing ceph-qa-suite in
> > teuthology.
> > INFO:teuthology.run_tasks:Running task internal.save_config...
> > INFO:teuthology.task.internal:Saving configuration
> > INFO:teuthology.run_tasks:Running task internal.check_lock...
> > INFO:teuthology.task.internal:Checking locks...
> > INFO:teuthology.lock:GET request to
> > 'http://pradeep:4000/lock/pradeep@pradeep.com' with body 'None' failed
> > with response code 404
> > ERROR:teuthology.run_tasks:Saw exception from tasks
> > Traceback (most recent call last):
> >   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/run_tasks.py",
> > line 25, in run_tasks
> >     manager = _run_one_task(taskname, ctx=ctx, config=config)
> >   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/run_tasks.py",
> > line 14, in _run_one_task
> >     return fn(**kwargs)
> >   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/task/internal.py",
> > line 110, in check_lock
> >     'could not read lock status for {name}'.format(name=machine)
> > AssertionError: could not read lock status for pradeep@pradeep.com
> >
> > The conf file is: lock_server: http://pradeep:4000/lock.
> >
> > With thanks
> > Pradeep S
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
