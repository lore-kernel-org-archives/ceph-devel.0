From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: Jenkins build pestered by 'no such option:
 --disable-pip-version-check'
Date: Tue, 19 Jul 2016 08:58:31 -0400
Message-ID: <f4d2f173-00e7-47f6-2de7-d1ffc6b8837f@redhat.com>
References: <65d919f9-a015-4fe8-b578-b2fc275494de@digiware.nl>
 <CAC-Np1xhGOo9JUcVm=4yqhN7FJJVFwxrGPXs30Rhw6a5ava_sg@mail.gmail.com>
 <04152f22-d98e-4c17-6ad4-8895b4d8682b@digiware.nl>
Reply-To: dang@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:32892 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbcGSM6e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 08:58:34 -0400
Received: by mail-qt0-f181.google.com with SMTP id w38so8535244qtb.0
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 05:58:34 -0700 (PDT)
In-Reply-To: <04152f22-d98e-4c17-6ad4-8895b4d8682b@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/18/2016 03:08 PM, Willem Jan Withagen wrote:
> On 18-7-2016 20:48, Alfredo Deza wrote:
>> On Mon, Jul 18, 2016 at 9:57 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Since somewhere last week all my Jenkins test are aborted this.
>>> And I was under the assumption that issue would have been fixed?
>>>
>>> --WjW
>>>
>>> See:
>>> https://jenkins.ceph.com/job/ceph-pull-requests/9255/console
>>>
>>> Running virtualenv with interpreter /usr/bin/python2.7
>>>
>>> Usage:
>>>   pip <command> [options]
>>>
>>> no such option: --disable-pip-version-check
>>>
>>> Usage:
>>>   pip <command> [options]
>>>
>>> no such option: --disable-pip-version-check
>>>
>>> Usage:
>>>   pip <command> [options]
>>
>>
>> That seems to be a problem in the code that creates the ceph-disk
>> virtual environment (python's virtualenv).
>>
>> That code lives within the Ceph source tree so a fix would need to
>> happen there (the Jenkins job can't really fix this)
>>
>> The full error (to make it easier for others to see) is:
>>
>> New python executable in /tmp/ceph.V2f/ceph-disk-virtualenv/bin/python2.7
>> Also creating executable in /tmp/ceph.V2f/ceph-disk-virtualenv/bin/python
>> Installing setuptools, pip...
>> done.
>> Running virtualenv with interpreter /usr/bin/python2.7
>>
>> Usage:
>>   pip <command> [options]
>>
>> no such option: --disable-pip-version-check
>>
>> Usage:
>>   pip <command> [options]
>>
>> no such option: --disable-pip-version-check
>>
>> Usage:
>>   pip <command> [options]
>>
>> no such option: --disable-pip-version-check
>> make[3]: *** [src/ceph-disk/CMakeFiles/ceph-disk] Error 2
>> make[2]: *** [src/ceph-disk/CMakeFiles/ceph-disk.dir/all] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>
> Yup,
> I totally agree, but why am I (the only one) suffering from this?
>
> Where as the code is plainly in the tree if you
>    grep -R disable-pip-version-check .
> at the root of the tree.
> And I think more pepeles tests should suffer from this if they are
> running in env's where pip does not have this option.
>
> Even more wierd is that the VM claims to be running trusty, and I'd
> expect it to run a rather recent pip after installation?
>
> But I'm still trying get the hang of all this python trickery.
>
> --WjW
>

You have a very old version of pip.  There's a PR in the works to fix this.

Daniel
