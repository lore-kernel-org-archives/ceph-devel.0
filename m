From: Sam Lang <slang@inktank.com>
Subject: Re: [ceph-users] CTDB Cluster Samba on Cephfs
Date: Tue, 16 Apr 2013 10:41:40 -0500
Message-ID: <CAKMAVE_8W8sL4_i1_V1pRJw2vTTX3yno6dZQcuXzBVWVPAPp9w@mail.gmail.com>
References: <CAKMAVE9FBKzZwrrO9psK-h95V6V=tufnsRApu7mMjc5cZx7_cQ@mail.gmail.com>
	<20130412231423.GB8603@samba2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:45262 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935563Ab3DPPll (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 11:41:41 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so619356oag.22
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 08:41:40 -0700 (PDT)
In-Reply-To: <20130412231423.GB8603@samba2>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeremy Allison <jra@samba.org>
Cc: Kai Blin <kai@samba.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Volker.Lendecke@sernet.de, samba-technical <samba-technical@lists.samba.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Apr 12, 2013 at 6:14 PM, Jeremy Allison <jra@samba.org> wrote:
> On Wed, Apr 03, 2013 at 03:53:58PM -0500, Sam Lang wrote:
>> On Thu, Mar 28, 2013 at 6:32 AM, Kai Blin <kai@samba.org> wrote:
>> > -----BEGIN PGP SIGNED MESSAGE-----
>> > Hash: SHA1
>> >
>> > On 2013-03-28 09:16, Volker Lendecke wrote:
>> >> On Wed, Mar 27, 2013 at 10:43:36PM -0700, Matthieu Patou wrote:
>> >>> On 03/27/2013 10:41 AM, Marco Aroldi wrote:
>> >>>> Hi list, I'm trying to create a active/active Samba cluster on
>> >>>> top of Cephfs I would ask if Ceph fully supports CTDB at this
>> >>>> time.
>> >>> If I'm not wrong Ceph (even CephFS) do not support exporting a
>> >>> block device or mounting the same FS more than once whereas CTDB
>> >>> explicitly require that you have a distributed filesystem where
>> >>> the same filesystem is mounted across all the nodes.
>> >>
>> >> Is that true? I thought Ceph was one of the cluster filesystems
>> >> doing just that. What is Ceph if not a cluster file system?
>> >
>> > There's some problem with mounting the in-kernel cephfs driver on
>> > systems running the osd, iirc. I had to use the fuse-based driver to
>> > mount, which obviously is not too great, speed-wise.
>> > See http://ceph.com/docs/master/faq/#try-ceph for a better description
>> > of the issue.
>>
>> Just to let folks know, we have a ceph vfs driver for samba that we
>> are testing out now.  We're planning to resolve a few of the bugs that
>> we're seeing presently with smbtorture, and send a pull request to the
>> samba repo.  If anyone wants to help with testing, let us know.  The
>> changes currently reside in the ceph branch of
>> http://github.com/ceph/samba.
>
> Does the libceph have an async API ?
>
> If we could plug it into the Samba async VFS pread_send/pwrite_send
> API you'd get much better performance.
>
> If libceph is thread-safe you could create your own modified
> version of vfs_aio_pthread() that called the ceph backend
> (although you'll need the ability to set credentials into
> the ceph userspace calls to cope with seteuid changes).

It doesn't have an async API, but the internals of libcephfs are all
asynchronous, so adding an async API shouldn't be hard.
-sam

>
> Jeremy.
