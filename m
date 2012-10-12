From: Pradeep S <pradeeps192@gmail.com>
Subject: Re: error: could not read lock status
Date: Fri, 12 Oct 2012 10:23:10 +0530
Message-ID: <CAB0Uiv2Wpc_a6qt7-CgFLGp_oqkuoqLLfRczENP=0eOcAFdyYw@mail.gmail.com>
References: <CAB0Uiv0-k0zgS5yTj23uXdU8W5t9ejwYVCs+9XhqWC14+PKrWA@mail.gmail.com>
	<CAPYLRzjKW8ruuDPJaBO4E7Cb3u65zUb3rDZO+Jvn6+asypVTNg@mail.gmail.com>
	<alpine.DEB.2.00.1210030916070.23173@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51788 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab2JLExM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Oct 2012 00:53:12 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1584473eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 11 Oct 2012 21:53:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210030916070.23173@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

hi, thanks for the reply.
As per your suggestion i have modified the yaml by
including,check-locks: false and also added as per suggestion in the
ceph-commit thread.

queue_host:pradeep(host)
queue_port:4000(as mentioned during the configuration of webui)
thanks that the lock status error is gone,but other error is shown as below.
File "/home/pradeep/Downloads/ceph-teuthology-0395df3/virtualenv/local/lib/python2.7/site-packages/yaml/scanner.py",
line 289, in stale_possible_simple_keys
    "could not found expected ':'", self.get_mark())
yaml.scanner.ScannerError: while scanning a simple key
  in "/home/pradeep/.teuthology.yaml", line 3, column 1
could not found expected ':'
  in "/home/pradeep/.teuthology.yaml", line 4, column 1
and also tell me whether to add check-locks: false, in the task.yaml
file or the ./teuthology.yaml file. However i have tried both the
ways.

some times the error also would be:
 File "/home/pradeep/Downloads/ceph-teuthology-0395df3/virtualenv/local/lib/python2.7/site-packages/yaml/scanner.py",
line 257, in fetch_more_tokens
    % ch.encode('utf-8'), self.get_mark())
yaml.scanner.ScannerError: while scanning for the next token
found character '\t' that cannot start any token
  in "rbd_api_tests_old_format1.yaml", line 14, column 27


with Regards
Pradeep S


On Wed, Oct 3, 2012 at 9:46 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 3 Oct 2012, Gregory Farnum wrote:
>> Check out the thread titled "[ceph-commit] teuthology lock_server error". :)
>
> In case it didn't hit ceph-devel:
>
> Add
>
> check-locks: false
>
> to your yaml file and the lock checks will all go away.
>
> sage
>
>
>>
>> On Wed, Oct 3, 2012 at 5:41 AM, Pradeep S <pradeeps192@gmail.com> wrote:
>> > hi, i am getting the following error while executing ceph-qa-suite in
>> > teuthology.
>> > INFO:teuthology.run_tasks:Running task internal.save_config...
>> > INFO:teuthology.task.internal:Saving configuration
>> > INFO:teuthology.run_tasks:Running task internal.check_lock...
>> > INFO:teuthology.task.internal:Checking locks...
>> > INFO:teuthology.lock:GET request to
>> > 'http://pradeep:4000/lock/pradeep@pradeep.com' with body 'None' failed
>> > with response code 404
>> > ERROR:teuthology.run_tasks:Saw exception from tasks
>> > Traceback (most recent call last):
>> >   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/run_tasks.py",
>> > line 25, in run_tasks
>> >     manager = _run_one_task(taskname, ctx=ctx, config=config)
>> >   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/run_tasks.py",
>> > line 14, in _run_one_task
>> >     return fn(**kwargs)
>> >   File "/home/pradeep/Downloads/ceph-teuthology-0395df3/teuthology/task/internal.py",
>> > line 110, in check_lock
>> >     'could not read lock status for {name}'.format(name=machine)
>> > AssertionError: could not read lock status for pradeep@pradeep.com
>> >
>> > The conf file is: lock_server: http://pradeep:4000/lock.
>> >
>> > With thanks
>> > Pradeep S
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
