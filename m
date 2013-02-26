From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crash and strange things on MDS
Date: Tue, 26 Feb 2013 10:10:06 -0800
Message-ID: <CAPYLRziS4rTVWU8C1fDJ6W6jgk7s9SOVnRGOcdiH9YshqGNaww@mail.gmail.com>
References: <20130211185424.GA27669@kdecherf.com>
	<CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
	<20130213114750.GC7399@kdecherf.com>
	<CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
	<20130216010217.GA26823@kdecherf.com>
	<CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
	<20130216182403.GB5313@kdecherf.com>
	<CAPYLRzibP6m3iEBMLs-B2u8t-cjv5-BE8_58dh55h7V2kzXSfQ@mail.gmail.com>
	<20130220010052.GO7121@kdecherf.com>
	<CAPYLRzgkR61eFuGU_NdL88bJvOD2em+TMO7g1g+X3RTFAZvY5Q@mail.gmail.com>
	<20130226175742.GE16091@kdecherf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:60032 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab3BZSKH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 13:10:07 -0500
Received: by mail-we0-f175.google.com with SMTP id x8so3777713wey.6
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 10:10:06 -0800 (PST)
In-Reply-To: <20130226175742.GE16091@kdecherf.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Decherf <kevin@kdecherf.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Tue, Feb 26, 2013 at 9:57 AM, Kevin Decherf <kevin@kdecherf.com> wro=
te:
> On Tue, Feb 19, 2013 at 05:09:30PM -0800, Gregory Farnum wrote:
>> On Tue, Feb 19, 2013 at 5:00 PM, Kevin Decherf <kevin@kdecherf.com> =
wrote:
>> > On Tue, Feb 19, 2013 at 10:15:48AM -0800, Gregory Farnum wrote:
>> >> Looks like you've got ~424k dentries pinned, and it's trying to k=
eep
>> >> 400k inodes in cache. So you're still a bit oversubscribed, yes. =
This
>> >> might just be the issue where your clients are keeping a bunch of
>> >> inodes cached for the VFS (http://tracker.ceph.com/issues/3289).
>> >
>> > Thanks for the analyze. We use only one ceph-fuse client at this t=
ime
>> > which makes all "high-load" commands like rsync, tar and cp on a h=
uge
>> > amount of files. Well, I will replace it by the kernel client.
>>
>> Oh, that bug is just an explanation of what's happening; I believe i=
t
>> exists in the kernel client as well.
>
> After setting the mds cache size to 900k, storms are gone.
> However we continue to observe high latency on some clients (always t=
he
> same clients): each IO takes between 40 and 90ms (for example with
> Wordpress, it takes ~20 seconds to load all needed files...).
> With a non-laggy client, IO requests take less than 1ms.

I can't be sure from that description, but it sounds like you've got
one client which is generally holding the RW "caps" on the files, and
then another client which comes in occasionally to read those same
files. That requires the first client to drop its caps, and involves a
couple round-trip messages and is going to take some time =97 this is a=
n
unavoidable consequence if you have clients sharing files, although
there's probably still room for us to optimize.

Can you describe your client workload in a bit more detail?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
