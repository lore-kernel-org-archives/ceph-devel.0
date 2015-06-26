From: Gregory Farnum <greg@gregs42.com>
Subject: Re: What is omap
Date: Fri, 26 Jun 2015 14:48:15 +0100
Message-ID: <CAJY_B6RCA+3s3r+7B=s8pYomrrnTscSsd77PSL8QsJFbeOG6jQ@mail.gmail.com>
References: <20150624234728.79c29b49@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35707 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbbFZNsQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jun 2015 09:48:16 -0400
Received: by igblr2 with SMTP id lr2so13648002igb.0
        for <ceph-devel@vger.kernel.org>; Fri, 26 Jun 2015 06:48:15 -0700 (PDT)
In-Reply-To: <20150624234728.79c29b49@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

[ Re-send to include the ceph-devel list; sorry for the double mail. ]

On Thu, Jun 25, 2015 at 6:47 AM, Pete Zaitcev <zaitcev@redhat.com> wrot=
e:
> Dear All:
>
> I am a complete beginner in Ceph and due to various circumstances I b=
ecame
> curious about omap. I made some quick web searches and read some rand=
om
> writings about it, but I still have basic questions.
>
>  - If I had to refer to omap in a doc/foo.rst, is there a canonical
>    web-page, blog post, mailing list thread, or a (white)paper that
>    serves to explain what it is?
>
>    So far the best explanation I found was in ceph-devel archives
>    by Gregory Farnum.
>
>  - Every casual explanation I found presumes that "an omap" (a set
>    of K/V) is associated with an object. But it is not physically in
>    the object. So, is there a free-standing omap (set of keys)?
>    Or an omap associated with something else, like a pool?
>
>  - Greg says " The on-disk layout for these is more complicated
>    (read about leveldb if you're interested)". Fair enough... But wou=
ld
>    someone be willing to shortcut this for me by explaining how this
>    works in concert with OSD. In particular, does OSD replicate
>    the files that LevelDB uses (like, for instance, Swift replicates
>    SQLite files), or does it rely on LevelDB's own replication?
>    Or perhaps OSD replicates upper level view of K/V provided by
>    LevelDB in a node and ignores its actual on-disk layout?

Each object consists of three different data storage areas, all of
which are 100% optional: the "bundle of bits" object data, the object
xattrs, and the object omap key-value store. It might help you to
think of each of these as a different kind of resource fork or stream.

The object data is most commonly stored as a single file in a local
filesystem on the OSD; the xattrs are most commonly stored as xattrs
on that file, and the omap is most commonly stored within a leveldb
instance. Each OSD has its *own* local leveldb where all that data
goes; there's no cross-OSD LevelDB replication or communication. We
tell you that the omap data is stored in LevelDB to give you an idea
what kind of data is good to put in it, but we don't want you to get
too hung up on the fact that it's using LevelDB =E2=80=94 it could chan=
ge in
the future! omap is just an optimized region for storing key-value
data.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
