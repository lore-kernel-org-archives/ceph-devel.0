From: Sage Weil <sage@newdream.net>
Subject: Re: about filestore->journal->rebuild_align
Date: Tue, 24 Oct 2017 02:32:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710240229050.16763@piezo.us.to>
References: <7DF47FD5BC069E4BBD28890C798EC7BC693272DE@H3CMLB12-EX.srv.huawei-3com.com> <7DF47FD5BC069E4BBD28890C798EC7BC69327315@H3CMLB12-EX.srv.huawei-3com.com> <7DF47FD5BC069E4BBD28890C798EC7BC69327620@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2130847395-1508812327=:16763"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:47815 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdJXCcI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Oct 2017 22:32:08 -0400
In-Reply-To: <7DF47FD5BC069E4BBD28890C798EC7BC69327620@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Liuhao <liu.haoA@h3c.com>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2130847395-1508812327=:16763
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 24 Oct 2017, Liuhao wrote:

> Hi, lister:
> I use ceph’version 10.2.0
> 
> Analysis FileJournal::prepare_entry，when prepare journal bufferlist，it’s divided into 5 parts：head  pre_pad  data  post_pad  head
> Then reuild for buffer list to 4K align。rebuild_aligned remalloc 4K aligned memory。（each 4K aligned memory is as small as possible）
> 
> Detailed code：
> FileJournal::prepare_entry(vector<ObjectStore::Transaction>& tls, bufferlist* tbl)
>          Encode for transaction  ::encode(*p, bl);
> 　　ebl.append((const char*)&h, sizeof(h));

This copies into the bufferlist::append_buffer, which is a 4k aligned 
page.

> 　　ebl.push_back(buffer::create_static(h.pre_pad, zero_buf));

This should be ebl.append_zeros(h.pre_pad);

> 　　ebl.claim_append(bl, buffer::list::CLAIM_ALLOW_NONSHAREABLE); // potential zero-copy

This does not, however.  We could probably change this so that if 
bl.length() < something we copy into the buffer here instead of doing a 
rebuild later.

> 　　ebl.push_back(buffer::create_static(h.post_pad, zero_buf));

Here too.

> 　　ebl.append((const char*)&h, sizeof(h));
> 　　ret = ebl.rebuild_aligned(CEPH_DIRECTIO_ALIGNMENT);
> 　　
> question:
> before rebuild_aligned，as many ptr is aligned as 4K，so you can apply less memory.is it?
> head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40  total:4K*1026
> rebuild_aligned will remalloc memory 4K*1026, all need rebuild

IIRC it's supposed to only rebuild the unaligned buffers.  So the header 
and padding will get rebuilt, but if the buffer bl is already aligned it 
will be untouched.  This is normally the case for large writes as the 
messenger takes care to read the data payload into memory with the correct 
alignment.

 
> Detail log info:
> In code, this log message caught my attention，the log information of these 5 valuse is not expected.
> 
> dout(10) << " len " << bl.length() << " -> " << size  << " (head " << head_size << " pre_pad " << h.pre_pad
>        << " bl " << bl.length() << " post_pad " << post_pad << " tail " << head_size << ")"
>        << " (bl alignment " << data_align << ")" << dendl;
> 
> 2017-10-17 19:50:28.721922 7f21d73fe700 10 journal  len 4196233 -> 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl alignment 2776)
> 2017-10-17 19:50:28.873261 7f21ccfff700 10 journal  len 4196131 -> 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl alignment 4086)
> 2017-10-17 19:50:28.897520 7f21d43ff700 10 journal  len 4196131 -> 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl alignment 4086)
> 2017-10-17 19:50:28.974811 7f21cf800700 10 journal  len 4196131 -> 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl alignment 4086)
> 2017-10-17 19:50:29.013940 7f21ccfff700 10 journal  len 4196215 -> 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl alignment 2794)
> 2017-10-17 19:50:29.292165 7f21ce3ff700 10 journal  len 4196215 -> 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl alignment 2794)
> 2017-10-17 19:50:29.311296 7f21cf800700 10 journal  len 4196233 -> 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl alignment 2776)
> 2017-10-17 19:50:29.416240 7f21d43ff700 10 journal  len 4196215 -> 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl alignment 2794)
> 2017-10-17 19:50:30.111561 7f21cc7fe700 10 journal  len 4196131 -> 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl alignment 4086)
> 2017-10-17 19:50:30.444729 7f21d23ff700 10 journal  len 4196131 -> 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl alignment 4086)
> 2017-10-17 19:50:30.448686 7f21ccfff700 10 journal  len 4196233 -> 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl alignment 2776)
> 2017-10-17 19:50:30.559626 7f21d43ff700 10 journal  len 4196131 -> 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl alignment 4086)
> 2017-10-17 19:50:30.592541 7f21d63fe700 10 journal  len 4196233 -> 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl alignment 2776)
> 2017-10-17 19:50:30.599527 7f21cb7ff700 10 journal  len 4196215 -> 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl alignment 2794)
> 2017-10-17 19:50:30.613123 7f21d13ff700 10 journal  len 4196131 -> 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl alignment 4086)

Is this a CephFS workload?

The alignment is confusing because it's aligning to the object offset.  So 
if you're writing 200 bytes into a file, you're 200 bytes into the first 
object, and the padding will be something like 200 - header size.

sage
--8323329-2130847395-1508812327=:16763--
