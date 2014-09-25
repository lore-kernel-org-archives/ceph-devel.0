From: Alfredo Deza <adeza@redhat.com>
Subject: Re: v0.67.11 dumpling released
Date: Thu, 25 Sep 2014 13:41:27 -0400
Message-ID: <CANtztVxS9jYJtyqiP08+zK-D_k=kdTGWnU13o=z-JUR6DuNXzw@mail.gmail.com>
References: <alpine.DEB.2.00.1409250808190.15854@cobra.newdream.net>
	<54245084.7040708@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:50152 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaIYRl3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 13:41:29 -0400
Received: by mail-wi0-f169.google.com with SMTP id fb4so8795304wid.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 Sep 2014 10:41:28 -0700 (PDT)
In-Reply-To: <54245084.7040708@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, ceph-maintainers@ceph.com

On Thu, Sep 25, 2014 at 1:27 PM, Mike Dawson <mike.dawson@cloudapt.com> wrote:
> Looks like the packages have partially hit the repo, but at least the
> following are missing:
>
> Failed to fetch
> http://ceph.com/debian-dumpling/pool/main/c/ceph/librbd1_0.67.11-1precise_amd64.deb
> 404  Not Found
> Failed to fetch
> http://ceph.com/debian-dumpling/pool/main/c/ceph/librados2_0.67.11-1precise_amd64.deb
> 404  Not Found
> Failed to fetch
> http://ceph.com/debian-dumpling/pool/main/c/ceph/python-ceph_0.67.11-1precise_amd64.deb
> 404  Not Found
> Failed to fetch
> http://ceph.com/debian-dumpling/pool/main/c/ceph/ceph_0.67.11-1precise_amd64.deb
> 404  Not Found
> Failed to fetch
> http://ceph.com/debian-dumpling/pool/main/c/ceph/libcephfs1_0.67.11-1precise_amd64.deb
> 404  Not Found
>
> Based on the timestamps of the files that made it, it looks like the process
> to publish the packages isn't still in process, but rather failed yesterday.

That is odd. I just went ahead and re-pushed the packages and they are
now showing up.

Thanks for letting us know!


>
> Thanks,
> Mike Dawson
>
>
> On 9/25/2014 11:09 AM, Sage Weil wrote:
>>
>> v0.67.11 "Dumpling"
>> ===================
>>
>> This stable update for Dumpling fixes several important bugs that affect a
>> small set of users.
>>
>> We recommend that all Dumpling users upgrade at their convenience.  If
>> none of these issues are affecting your deployment there is no urgency.
>>
>>
>> Notable Changes
>> ---------------
>>
>> * common: fix sending dup cluster log items (#9080 Sage Weil)
>> * doc: several doc updates (Alfredo Deza)
>> * libcephfs-java: fix build against older JNI headesr (Greg Farnum)
>> * librados: fix crash in op timeout path (#9362 Matthias Kiefer, Sage
>> Weil)
>> * librbd: fix crash using clone of flattened image (#8845 Josh Durgin)
>> * librbd: fix error path cleanup when failing to open image (#8912 Josh
>> Durgin)
>> * mon: fix crash when adjusting pg_num before any OSDs are added (#9052
>>    Sage Weil)
>> * mon: reduce log noise from paxos (Aanchal Agrawal, Sage Weil)
>> * osd: allow scrub and snap trim thread pool IO priority to be adjusted
>>    (Sage Weil)
>> * osd: fix mount/remount sync race (#9144 Sage Weil)
>>
>> Getting Ceph
>> ------------
>>
>> * Git at git://github.com/ceph/ceph.git
>> * Tarball at http://ceph.com/download/ceph-0.67.11.tar.gz
>> * For packages, see http://ceph.com/docs/master/install/get-packages
>> * For ceph-deploy, see
>> http://ceph.com/docs/master/install/install-ceph-deploy
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
