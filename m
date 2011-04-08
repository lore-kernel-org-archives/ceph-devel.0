From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Management of radosgw
Date: Fri, 08 Apr 2011 20:44:54 +0200
Message-ID: <1302288294.2444.9.camel@wido-laptop.pcextreme.nl>
References: <BANLkTikFSByoz-BNQFaw7WSh5R0aZEcWew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:46328 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293Ab1DHSoz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2011 14:44:55 -0400
In-Reply-To: <BANLkTikFSByoz-BNQFaw7WSh5R0aZEcWew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On Fri, 2011-04-08 at 21:18 +0800, Sylar Shen wrote:
> Hi,
> Recently I am testing radosgw and there are some questions that came
> up in my mind.
> I observed that radosgw stores the records of user accounts or
> metadata of files in MDS.

The radosgw does not use the MDS at all, the MDS is only used for the
Ceph POSIX filesystem.

> But it seems that radosgw stores them in the form of pieces which I
> cannot get a readable information by typing a command.

Indeed, user information is stored in the .rgw, .users and .users.email
pools.

> I am curious that is there a way I can manage the records of radosgw?
> For example, if I want to know how many users are there in radosgw and
> the detail information of each user(ID, access key, secret key).
> Or if I want to know a user about the information of directories or
> files he created.
> Are there some commands that I can use to see the information that I
> want to see?

For now the "radosgw_admin" is the tool for the job, it still lacks some
functionality, but it's a work-in-progress.

But what you could do for example:

root@gateway:~# rados -p .users ls
EQCZHQ0KW2GPG8HKCS82
EQCZHQ0KW2GPG8HKCS82.buckets
root@gateway:~# radosgw_admin user info --uid=EQCZHQ0KW2GPG8HKCS82
RADOS S3 Gateway: rados->read ofs=0 len=16384
RADOS S3 Gateway: rados->read r=128
User ID: EQCZHQ0KW2GPG8HKCS82
Secret Key: dA0WHJIIKANaft7qBqL1GfPKAufgx49czYtzggLH
Display Name: Wido den Hollander
OpenStack User: <undefined>
OpenStack Key: <undefined>
root@gateway:~#

If you have suggestions for the radosgw, please add them to the issue
tracker as a feature request: http://tracker.newdream.net/projects/ceph

Thank you,

Wido

> Thank in advance!
> ps: please correct me if I said something wrong about radosgw.


