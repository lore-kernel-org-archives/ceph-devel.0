From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: Braindump: multiple clusters on the same hardware
Date: Sat, 20 Oct 2012 10:53:46 +0100
Message-ID: <2C82B5D8-5AB4-4FAB-9239-F2BE2FA2FD9E@tchpc.tcd.ie>
References: <CADvuQREhkrqxm1dMo3XXFpwhtCzC7SM7cK_7+r5HnACGbCnJLw@mail.gmail.com> <4F329E1D-EACC-497E-B9E4-445992BA4F35@tchpc.tcd.ie> <A91A18BC-9B52-45E6-953F-7A13B6716275@tchpc.tcd.ie>  <sfid-H20121018-174727-+035.14-1@marduk.tchpc.tcd.ie> <CADvuQRF-3ThfrLtDm5fxFBMxa=C1vei3iseMnpBPpw-_sz==Yg@mail.gmail.com>  (sfid-H20121018-174727-+035.14-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:45885 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab2JTJxv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Oct 2012 05:53:51 -0400
In-Reply-To: <CADvuQRF-3ThfrLtDm5fxFBMxa=C1vei3iseMnpBPpw-_sz==Yg@mail.gmail.com>  (sfid-H20121018-174727-+035.14-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org, John Wilkins <john.wilkins@inktank.com>


On 18 Oct 2012, at 17:47, Tommi Virtanen wrote:

> On Thu, Oct 18, 2012 at 7:40 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
>> What I actually meant to ask was, is it possible to copy objects or pools from one ceph cluster to another (for disaster recovery reasons) and if this feature is planned or even considered?
> 
> That's the "async replication for disaster recovery" feature that has
> been mentioned every now and then.
> 
> You could build it as "read from one cluster, write to another"
> yourself, the client libraries are perfectly able to talk to two
> clusters at once. Ceph itself doesn't have that feature currently, but
> might in the future. It's definitely on the roadmap, and asked for a
> lot.
> 

that sounds promising that it is possible to do it. It's certainly a feature that would be highly desirable  for preservation and archival systems.

> This has nothing to do with the "many clusters on the same hardware"
> feature this thread is about..
> 

I figured that out after I had sent the email.


Jimmy.