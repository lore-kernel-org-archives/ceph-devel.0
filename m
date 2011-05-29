From: Sylar Shen <kimulaaa@gmail.com>
Subject: Re: Quota function of radosgw
Date: Sun, 29 May 2011 10:45:45 +0800
Message-ID: <BANLkTimMsGNtOABRXFd24YeNumLM0gQzKw@mail.gmail.com>
References: <BANLkTikpoxS6ZzPJ6q9iUD9etawm24rApQ@mail.gmail.com>
	<BANLkTikaeMSQ1PVoAopSxeqB5pmELuzGow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41112 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab1E2Cpr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 May 2011 22:45:47 -0400
Received: by bwz15 with SMTP id 15so2131802bwz.19
        for <ceph-devel@vger.kernel.org>; Sat, 28 May 2011 19:45:46 -0700 (PDT)
In-Reply-To: <BANLkTikaeMSQ1PVoAopSxeqB5pmELuzGow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Gregory,
Thanks for your information very much!
Dropbox could limit the quota value of each user.
Does Dropbox implement the quota function by recording every size of
file in its own database?
Or Dropbox just controls the quota of each user by the client application?
If Dropbox did neither of the two approaches above, how did they do?
Sorry it may be a little stupid question but I am curious about that......:p

By the way, the test of re-exporting NFS I did worked not bad.
And I am wondering since Ceph can re-export NFS, then can Ceph
re-export SAMBA that connects to windows?
Thanks~~^^

--
Best Regards,
Sylar Shen

2011/5/28 Gregory Farnum <gregf@hq.newdream.net>:
> On Fri, May 27, 2011 at 9:06 AM, Sylar Shen <kimulaaa@gmail.com> wrote:
>> Hi developers,
>> Recently I am testing radosgw about its functions.
>> Then I am curious that will radosgw implement the function or API of
>> quota in the future?
>> I've checked the mail archives and found that the quota issue had been
>> discussed.
>> And also, I know this may affect the performance of write ability.
>> But in most cases, administrator may want to set the quota of a bucket
>> for every user.
>> So would this function be implemented in the future?
> We're unlikely to implement quotas in the gateway. It's an
> S3-compatible implementation and S3 has no concept of limits -- the
> more space users take up, the more money the provider can charge them!
> ;)
> Previous discussions of quotas have centered more on the full
> filesystem, which is technically challenging for a number of reasons,
> although I think the Tcloud guys have done some work on that.
> I don't think it would be too difficult to implement a working
> solution for the *gateway* layer on your own, though...
>
>
>> On another hand, I know that the kernel of Ceph upgrades gradually.
>> I would like to know that will the performance of Ceph client and
>> re-exporting NFS become better if I upgrade the kernel to the latest
>> version?
> The kernel client hasn't gone through a lot of updating lately, but
> the current rc release will be faster than recent kernels since it
> re-enables local dentry lookups (at last!).
> NFS re-export is getting more attention lately so it's better than it
> used to be, but there aren't a lot of users yet and there are still
> some weird performance issues that you'll run across in any version of
> it.
> -Greg
>



-- 
Best Regards,
Sylar Shen
