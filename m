From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: Ceph Full-SSD Performance Improvement
Date: Wed, 22 Oct 2014 13:18:13 -0400 (EDT)
Message-ID: <664940498.99.1413998293240.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <498515024.97.1413997901677.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2840 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008AbaJVRSb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Oct 2014 13:18:31 -0400
In-Reply-To: <498515024.97.1413997901677.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Samuel Just <sam.just@inktank.com>, icolle@redhat.com, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Hi,

----- "Haomai Wang" <haomaiwang@gmail.com> wrote:

> [cc to ceph-devel]
> 
> >> At first FileStore will directly accept inputs without bufferlist
> >> encode/decodes. Now I try to send MOSDOP's payload directly to
> >> replicate PG and avoid overall ObjectStore::Transaction which is

We did something similar to this in our internal OSD branch, it's a good idea.

> used
> >> by replicated pg. Replicated PG maybe need calculate again but as
> we
> >> performed the main consuming time in PG layer is transaction
> >> encode/decode. KeyValueStore and FileStore will both happy  to
> adopt
> >> it. Then main IO logic such as read/write ops won't need
> >> encode/decode.
> >
> > Can you send a message to ceph-devel with a bit more detail?  We
> used to
> > do this, actually (prepare the transaction on the replicas instead
> of
> > encoding the one from the primary) but it was a bit less flexible
> when it
> > came to the object classes (which might not be deterministic).
> >
> > I agree that encode/decode is a serious issue, but before
> > avoiding it for transations I'd like to see what Matt Benjamin
> > is able to accomplish with his changes, or look at ways to
> > make transaction encoding in particular more efficient (e.g.
> > with fixed size structures).  Also, you might be interested in
> >
> >        
> https://wiki.ceph.com/Planning/Blueprints/Hammer/osd%3A_update_Transaction_encoding
> 
> Hmm, I try to understand the meaning. Is this BP want to make
> ObjectStore::Transaction more flexible and make ObjectStore's
> successors can easily aware of the data layout in transaction. I try
> to summary the performance optimization for this bp:
> 
> 1. FileStore/KeyValueStore can aware of the size of write data and do
> something special for it, it would be nice for large file
> 2. A complexity transaction which contains several ops for one
> object,
>  the redundancy lookups will be reduced
> 
> But the actual consuming time component I think is transaction
> encode/decode. Especially encode/decode for ghobject_t and collection
> structure.

We also did some simplification here.

> 
> Combine with Message encode/decode, as I performed encode/decode
> logics plays a important role for the latency of op. I want to
> explain
> what I want to do:
> 
> All Messages will be restructured and have a common header. All
> members in Message will be fixed. I know some critical member such as
> ghobject_t or anything else will be hard to decisive. So on the
> Messenger side, ghobject_t or other flexible structure will have
> separated structure, like ghobject_t will be translated to
> Message::object which will packed into a fixed size memory. So
> Messenger can directly pick up structures in messages without memory
> copy and parsing. And on the side of PG layer,
> ObjectStore::Transaction will be refactored to a simple class. A list
> of ops will describe the sequences and all data will be referenced
> directly which is used in PG layer. It maybe let ObjectStore's
> successors less flexible but it's still has space to modify. For
> subop, the raw message from client will be validated in primary pg
> and
> add some infos necessary inser into the fixed position of the message
> and populate to replicate PG.

I've wanted to see work done in this area also.  I'm not as certain about the detail.  We've considered doing something with Message similar to what we're doing with buffer::raw and buffer::ptr, which sounds a bit similar.  I'm not 100% convinced that there might not be cleaner encode/decode strategies which do not give up as much flexibility as what is hinted
at here, though.  We've discussed some ideas internally.


-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
