From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: samba of Ceph
Date: Wed, 1 Jun 2011 22:35:06 -0700
Message-ID: <BANLkTi=ACRZ5AMz+HLRE-KXPXwC1WLQENA@mail.gmail.com>
References: <BANLkTin491FEmWbYaGXa9GYx219L2NoOeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51303 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab1FBFfH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2011 01:35:07 -0400
Received: by vws1 with SMTP id 1so394496vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2011 22:35:06 -0700 (PDT)
In-Reply-To: <BANLkTin491FEmWbYaGXa9GYx219L2NoOeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

I have tested that Samba does work over a cfuse or kernel mount point.
I only tested basic functionality via a dedicated user account (not AD)=
=2E
We'll soon be testing with AD and the acl_xattr VFS layer which stores
Windows ACLs on each file in the filesystem under the 'user.NTACL'
xattr as a blob.
That's largely independent of the ceph VFS module we're preparing,
which will keep this all in userspace.

On Wed, Jun 1, 2011 at 7:33 PM, Sylar Shen <kimulaaa@gmail.com> wrote:
> Dear Brian and Gregory,
> Thanks for your information about samba of Ceph.
> I am trying to use a Ceph client to mount Ceph DFS(/mnt/cephfs/) and
> set up a samba server to share the mount point(/mnt/cephfs/) to
> Windows 2008 AD.
> (Yes, I would like to integrate Windows Active Directory with a samba
> server which is also a Ceph client)
> However, I encountered one problem while doing so......><
> I cannot write or upload files via samba although the read function i=
s OK.
> Originally, I think I can fix it by changing /etc/fstab/ settings
> like...... "monitor_IP:/ =A0 =A0 =A0 /mnt/cephfs/ =A0 =A0 =A0btrfs
> defaults,acl =A0 =A01 2"
> But it's not working.......and I don't know how to solve this acl
> problem at all.......
> Brian said he is working on this. Does that mean I cannot just set up
> a samba server to share a Ceph mount point to Windows AD now?
> Maybe I have to wait until the function of re-export samba is finishe=
d?
> Thanks for your kindness to reply~~^^
>
> 2011/6/1 Brian Chrisman <brchrisman@gmail.com>
>>
>> On Tue, May 31, 2011 at 9:17 AM, Gregory Farnum <gregf@hq.newdream.n=
et> wrote:
>> > On Sat, May 28, 2011 at 7:45 PM, Sylar Shen <kimulaaa@gmail.com> w=
rote:
>> >> Hi Gregory,
>> >> Thanks for your information very much!
>> >> By the way, the test of re-exporting NFS I did worked not bad.
>> >> And I am wondering since Ceph can re-export NFS, then can Ceph
>> >> re-export SAMBA that connects to windows?
>> > We don't have a samba re-export functionality, although you can ju=
st
>> > run samba on a Ceph mount if you like. And I think bchrisman is
>> > working on one, but you'd have to ask him about that. :)
>>
>>
>> Richard Sharpe and I have a VFS layer integrating Ceph (libceph) wit=
h
>> Samba that is just a stone's throw from basic functionality.
>> Current status:
>> mount/init, stat, opendir, readdir, and a few other operations are w=
orking.
>> We're chasing down what appears to be a few smaller problems related
>> to read/write.
>> We've also used to the acl_xattr module to avoid doing a bunch of ac=
l
>> translations, though we could probably hit that in a second pass.
>> One future critical issue here is going to be the caching mechanism
>> and how it works with Samba's process model (process per connection)=
=2E
>> This merits a discussion about how multiple libceph clients will wor=
k
>> together when run on the same host.
>>
>> > -Greg
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>
>
>
> --
> Best Regards,
> Sylar Shen
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
