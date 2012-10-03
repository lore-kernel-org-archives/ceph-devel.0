From: Gregory Farnum <greg@inktank.com>
Subject: Re: error: could not read lock status
Date: Wed, 3 Oct 2012 09:10:36 -0700
Message-ID: <CAPYLRzjKW8ruuDPJaBO4E7Cb3u65zUb3rDZO+Jvn6+asypVTNg@mail.gmail.com>
References: <CAB0Uiv0-k0zgS5yTj23uXdU8W5t9ejwYVCs+9XhqWC14+PKrWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41328 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435Ab2JCQKg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 12:10:36 -0400
Received: by ieak13 with SMTP id k13so17573080iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 09:10:36 -0700 (PDT)
In-Reply-To: <CAB0Uiv0-k0zgS5yTj23uXdU8W5t9ejwYVCs+9XhqWC14+PKrWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pradeep S <pradeeps192@gmail.com>
Cc: ceph-devel@vger.kernel.org

Check out the thread titled "[ceph-commit] teuthology lock_server error". :)

On Wed, Oct 3, 2012 at 5:41 AM, Pradeep S <pradeeps192@gmail.com> wrote:
> hi, i am getting the following error while executing ceph-qa-suite in
> teuthology.
> INFO:teuthology.run_tasks:Running task internal.save_config...
> INFO:teuthology.task.internal:Saving configuration
> INFO:teuthology.run_tasks:Running task internal.check_lock...
> INFO:teuthology.task.internal:Checking locks...
> INFO:teuthology.lock:GET request to
> 'http://pradeep:4000/lock/pradeep@pradeep.com' with body 'None' failed
> with response code 404
> ERROR:teuthology.run_tasks:Saw exception from tasks
> Traceback (most recent call last):
>   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/run_tasks.py",
> line 25, in run_tasks
>     manager = _run_one_task(taskname, ctx=ctx, config=config)
>   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/run_tasks.py",
> line 14, in _run_one_task
>     return fn(**kwargs)
>   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/task/internal.py",
> line 110, in check_lock
>     'could not read lock status for {name}'.format(name=machine)
> AssertionError: could not read lock status for pradeep@pradeep.com
>
> The conf file is: lock_server: http://pradeep:4000/lock.
>
> With thanks
> Pradeep S
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
