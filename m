From: Florian Haas <florian@hastexo.com>
Subject: Re: [ceph-users] Status of snapshots in CephFS
Date: Wed, 24 Sep 2014 19:41:03 +0100
Message-ID: <5423103F.60702@hastexo.com>
References: <CAPUexz_pGTXdjbw90HKDQPzfXQNY=vormfxwvDLWpMvhD+eOYA@mail.gmail.com> <alpine.DEB.2.00.1409190820570.18018@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:65395 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbaIXSlJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Sep 2014 14:41:09 -0400
Received: by mail-wi0-f170.google.com with SMTP id fb4so7027524wid.5
        for <ceph-devel@vger.kernel.org>; Wed, 24 Sep 2014 11:41:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409190820570.18018@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 19, 2014 at 5:25 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 19 Sep 2014, Florian Haas wrote:
>> Hello everyone,
>>
>> Just thought I'd circle back on some discussions I've had with people
>> earlier in the year:
>>
>> Shortly before firefly, snapshot support for CephFS clients was
>> effectively disabled by default at the MDS level, and can only be
>> enabled after accepting a scary warning that your filesystem is highly
>> likely to break if snapshot support is enabled. Has any progress been
>> made on this in the interim?
>>
>> With libcephfs support slowly maturing in Ganesha, the option of
>> deploying a Ceph-backed userspace NFS server is becoming more
>> attractive -- and it's probably a better use of resources than mapping
>> a boatload of RBDs on an NFS head node and then exporting all the data
>> from there. Recent snapshot trimming issues notwithstanding, RBD
>> snapshot support is reasonably stable, but even so, making snapshot
>> data available via NFS, that way, is rather ugly. In addition, the
>> libcephfs/Ganesha approach would obviously include much better
>> horizontal scalability.
>
> We haven't done any work on snapshot stability.  It is probably moderately
> stable if snapshots are only done at the root or at a consistent point in
> the hierarcy (as opposed to random directories), but there are still some
> basic problems that need to be resolved.  I would not suggest deploying
> this in production!  But some stress testing woudl as always be very
> welcome.  :)

OK, on a semi-related note: is there any reasonably current
authoritative list of features that are supported and unsupported in
either ceph-fuse or kernel cephfs, and if so, at what minimal version?

The most comprehensive overview that seems to be available is one from
Greg, which however is a year and a half old:

http://ceph.com/dev-notes/cephfs-mds-status-discussion/

>> In addition, https://github.com/nfs-ganesha/nfs-ganesha/wiki/ReleaseNotes_2.0#CEPH
>> states:
>>
>> "The current requirement to build and use the Ceph FSAL is a Ceph
>> build environment which includes Ceph client enhancements staged on
>> the libwipcephfs development branch. These changes are expected to be
>> part of the Ceph Firefly release."
>>
>> ... though it's not clear whether they ever did make it into firefly.
>> Could someone in the know comment on that?
>
> I think this is referring to the libcephfs API changes that the cohortfs
> folks did.  That all merged shortly before firefly.

Great, thanks for the clarification.

> By the way, we have some basic samba integration tests in our regular
> regression tests, but nothing based on ganesha.  If you really want this
> to the work, the most valuable thing you could do would be to help
> get the tests written and integrated into ceph-qa-suite.git.  Probably the
> biggest piece of work there is creating a task/ganesha.py that installs
> and configures ganesha with the ceph FSAL.

Hmmm, given the excellent writeup that Niels de Vos of Gluster fame
wrote about this topic, I might actually be able to cargo-cult some of
what's in the Samba task and adapt it for ganesha.

Sorry while I'm being ignorant about Teuthology: what platform does it
normally run on? I ask because I understand most of your testing is done
on Ubuntu, and Ubuntu currently doesn't ship a Ganesha package, which
would make the install task a bit more complex.

Cheers,
Florian
