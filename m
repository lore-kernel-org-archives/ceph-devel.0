From: Sage Weil <sage@newdream.net>
Subject: Re: reply: about filestore->journal->rebuild_align
Date: Wed, 25 Oct 2017 12:04:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710251203490.22592@piezo.us.to>
References: <7DF47FD5BC069E4BBD28890C798EC7BC6932785A@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2094014970-1508933087=:22592"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:33931 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdJYMEs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 08:04:48 -0400
In-Reply-To: <7DF47FD5BC069E4BBD28890C798EC7BC6932785A@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Liuhao <liu.haoA@h3c.com>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2094014970-1508933087=:22592
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 25 Oct 2017, Liuhao wrote:
> Thanks for your reply.
> 
> >Is this a CephFS workload?
> >The alignment is confusing because it's aligning to the object offset.  So if you're writing 200 bytes into a file, you're 200 bytes into the first object, and the padding will be something like 200 - header size.
> 
> Yes, this is cephFS。
> When I use rados bench to test, log info is same,so I think no matter what is used in upper layer(no matter cephFS or rbd ).
> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
> In func "FileJournal::prepare_entry",  "data_align" is used to make header to 4K aligned
>  
> Detail code:
> h.pre_pad = ((unsigned int)data_align - (unsigned int)head_size) & ~CEPH_PAGE_MASK;
> 
> how to get data_align? 
>    1. largest_data_off_in_tbl is important.
>    2. FileStore::_do_transaction -> _build_actions_from_tbl -> write(cid, oid, off, len, bl)
>    3. data.largest_data_off_in_tbl = tbl.length() + sizeof(__u32);  // we are about to
> 
> I think a transaction have many op, and "largest_data_off_in_tbl" is the largest op length, and use largest_data_off_in_tbl as alignment 
> Is that so? 

Correct. If there is, say, a small 4k write and a 1mb write in the same 
transaction, we want the alignment of the 1mb write so that that buffer 
doesn't have to be copied around to get properly alignment for direct-io.

sage


> Looking forward to your answer.
> 
> -----------------------------------------------------------------------------------------------
> 发件人: Sage Weil [mailto:sage@newdream.net] 
> 发送时间: 2017年10月24日 10:32
> 收件人: liuhao 13701
> 抄送: 'ceph-devel@vger.kernel.org'
> 主题: Re: about filestore->journal->rebuild_align
> 
> 
> 
> On Tue, 24 Oct 2017, Liuhao wrote:
> 
> > Hi, lister:
> > I use ceph’version 10.2.0
> > 
> > Analysis FileJournal::prepare_entry，when prepare journal 
> > bufferlist，it’s divided into 5 parts：head  pre_pad  data  post_pad  
> > head Then reuild for buffer list to 4K align。rebuild_aligned remalloc 
> > 4K aligned memory。（each 4K aligned memory is as small as possible）
> > 
> > Detailed code：
> > FileJournal::prepare_entry(vector<ObjectStore::Transaction>& tls, 
> > bufferlist* tbl)
> >          Encode for transaction  ::encode(*p, bl);
> > 　　ebl.append((const char*)&h, sizeof(h));
> 
> This copies into the bufferlist::append_buffer, which is a 4k aligned page.
> 
> > 　　ebl.push_back(buffer::create_static(h.pre_pad, zero_buf));
> 
> This should be ebl.append_zeros(h.pre_pad);
> 
> > 　　ebl.claim_append(bl, buffer::list::CLAIM_ALLOW_NONSHAREABLE); // 
> > potential zero-copy
> 
> This does not, however.  We could probably change this so that if
> bl.length() < something we copy into the buffer here instead of doing a rebuild later.
> 
> > 　　ebl.push_back(buffer::create_static(h.post_pad, zero_buf));
> 
> Here too.
> 
> > 　　ebl.append((const char*)&h, sizeof(h));
> > 　　ret = ebl.rebuild_aligned(CEPH_DIRECTIO_ALIGNMENT);
> > 　　
> > question:
> > before rebuild_aligned，as many ptr is aligned as 4K，so you can apply less memory.is it?
> > head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40  total:4K*1026 
> > rebuild_aligned will remalloc memory 4K*1026, all need rebuild
> 
> IIRC it's supposed to only rebuild the unaligned buffers.  So the header and padding will get rebuilt, but if the buffer bl is already aligned it will be untouched.  This is normally the case for large writes as the messenger takes care to read the data payload into memory with the correct alignment.
> 
>  
> > Detail log info:
> > In code, this log message caught my attention，the log information of these 5 valuse is not expected.
> > 
> > dout(10) << " len " << bl.length() << " -> " << size  << " (head " << 
> > head_size << " pre_pad " << h.pre_pad
> >        << " bl " << bl.length() << " post_pad " << post_pad << " tail " << head_size << ")"
> >        << " (bl alignment " << data_align << ")" << dendl;
> > 
> > 2017-10-17 19:50:28.721922 7f21d73fe700 10 journal  len 4196233 -> 
> > 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl 
> > alignment 2776)
> > 2017-10-17 19:50:28.873261 7f21ccfff700 10 journal  len 4196131 -> 
> > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > alignment 4086)
> > 2017-10-17 19:50:28.897520 7f21d43ff700 10 journal  len 4196131 -> 
> > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > alignment 4086)
> > 2017-10-17 19:50:28.974811 7f21cf800700 10 journal  len 4196131 -> 
> > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > alignment 4086)
> > 2017-10-17 19:50:29.013940 7f21ccfff700 10 journal  len 4196215 -> 
> > 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl 
> > alignment 2794)
> > 2017-10-17 19:50:29.292165 7f21ce3ff700 10 journal  len 4196215 -> 
> > 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl 
> > alignment 2794)
> > 2017-10-17 19:50:29.311296 7f21cf800700 10 journal  len 4196233 -> 
> > 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl 
> > alignment 2776)
> > 2017-10-17 19:50:29.416240 7f21d43ff700 10 journal  len 4196215 -> 
> > 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl 
> > alignment 2794)
> > 2017-10-17 19:50:30.111561 7f21cc7fe700 10 journal  len 4196131 -> 
> > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > alignment 4086)
> > 2017-10-17 19:50:30.444729 7f21d23ff700 10 journal  len 4196131 -> 
> > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > alignment 4086)
> > 2017-10-17 19:50:30.448686 7f21ccfff700 10 journal  len 4196233 -> 
> > 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl 
> > alignment 2776)
> > 2017-10-17 19:50:30.559626 7f21d43ff700 10 journal  len 4196131 -> 
> > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > alignment 4086)
> > 2017-10-17 19:50:30.592541 7f21d63fe700 10 journal  len 4196233 -> 
> > 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl 
> > alignment 2776)
> > 2017-10-17 19:50:30.599527 7f21cb7ff700 10 journal  len 4196215 -> 
> > 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl 
> > alignment 2794)
> > 2017-10-17 19:50:30.613123 7f21d13ff700 10 journal  len 4196131 -> 
> > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > alignment 4086)
> 
> Is this a CephFS workload?
> 
> The alignment is confusing because it's aligning to the object offset.  So if you're writing 200 bytes into a file, you're 200 bytes into the first object, and the padding will be something like 200 - header size.
> 
> sage
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-2094014970-1508933087=:22592--
