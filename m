From: Sage Weil <sage@inktank.com>
Subject: rados mailbox? (was Re: Ceph for email storage)
Date: Wed, 4 Jul 2012 13:40:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207041317110.6931@cobra.newdream.net>
References: <4FF48B9C.3010803@webcenter.com.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39770 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab2GDUkf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 16:40:35 -0400
In-Reply-To: <4FF48B9C.3010803@webcenter.com.br>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mitsue Acosta Murakami <mitsue@webcenter.com.br>
Cc: ceph-devel@vger.kernel.org

Although Ceph fs would technically work for storing mail with maildir, 
when you step back from the situation, Maildir + a distributed file system 
is a pretty terrible way to approach mail storage.  Maildir was designed 
to work around the limited consistency of NFS, and manages that, but 
performs pretty horribly on almost any file system.  Mostly this is due to 
the message-per-file approach and the fact that file systems' internal 
management of inodes and directories mean lots and lots of seeks, even to 
read message headers.  Ceph's MDS will probably do better than most due to 
its embedded inodes, but it's hardly ideal.

However, and idea that has been kicking around here is building a mail 
storage system directly on top of RADOS.  In principle, it should be a 
relatively straightforward matter of implementing a library and plugging 
it into the storage backend for something like Dovecot, or any other mail 
system (delivery agent and/or IMAP/POP frontend) with a pluggable backend.  
(I think postfix has pluggable delivery agents, but that's about where my 
experience in this area runs out.)

The basic idea is this:

 - each mail message is a rados object, and immutable.
 - each mailbox is an index of messages, stored in a rados object.
   - the index consists of omap records, one for each message.
   - the key is some unique id
   - the value is a copy of (a useful subset of) the message headers

This has a number of nice properties:

 - you can efficiently list messages in the mailbox using the omap 
   operations
 - you can (more) efficiently search messages (everything but the message 
   body) based on the index contents (since it's all stored in one object)
 - you can efficiently grab recent messages with the omap ops (e.g., list 
   keys > last_seen_msgid)
 - moving messages between folders involves updating the indices only; the
   messages objects need not be copied/moved.
 - no metadata bottleneck: mailbox indices are distributed across the 
   entire cluster, just like the mail.
 - all the scaling benefits of rados for a growing mail system.

I don't know enough about what exactly the mail storage backends need to 
support to know what issues will come up.  Presumably there are several.  
E.g., if you delete a message, is the IMAP client expected to discover 
that efficiently?  And do the mail storage backends attempt to do it 
efficiently?

This also doesn't solve the problem of efficiently indexing/searching the 
bodies of messages, although I suspect that indexing could be efficiently 
implemented on top of this scheme.

So, a non-trivial project, but probably one that can be prototyped without 
that much pain, and one that would perform and scale drastically better 
than existing solutions I'm aware of.

I'm hoping there are some motivated hackers lurking who understand the 
pain that is maildir/mail infrastructure...

sage



On Wed, 4 Jul 2012, Mitsue Acosta Murakami wrote:

> Hello,
> 
> We are examining Ceph to use as email storage. In our current system, several
> clients servers with different services (imap, smtp, etc) access a NFS storage
> server. The mailboxes are stored in Maildir format, with many small files. We
> use Amazon AWS EC2 for clients and storage server. In this scenario, we have
> some questions about Ceph:
> 
> 1. Is Ceph recommended for heavy write/read of small files?
> 
> 2. Is there any problem in installing Ceph on Amazon instances?
> 
> 3. Does Ceph already support quota?
> 
> 4. What File System would you encourage us to use?
> 
> 
> Thanks in advance,
> 
> -- 
> Mitsue Acosta Murakami
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
