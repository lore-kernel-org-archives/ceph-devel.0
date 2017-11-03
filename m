From: Sage Weil <sage@newdream.net>
Subject: Re: reply: reply: about filestore->journal->rebuild_align
Date: Fri, 3 Nov 2017 12:09:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711031208380.23234@piezo.novalocal>
References: <7DF47FD5BC069E4BBD28890C798EC7BC8C8C2DA0@H3CMLB14-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-722012086-1509710948=:23234"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:40230 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbdKCMJJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Nov 2017 08:09:09 -0400
In-Reply-To: <7DF47FD5BC069E4BBD28890C798EC7BC8C8C2DA0@H3CMLB14-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Liuhao <liu.haoA@h3c.com>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-722012086-1509710948=:23234
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 3 Nov 2017, Liuhao wrote:
> Hi, 
> version 10.2.0
> ./rados bench 20 -p rbd write -b 4M
> 
> alignment is 4086, pre_pad is 4046, rebuild_aligned will realloc memory 4202496
> If adjust the pre_pad from 4046 to 4042, realloc memory only 8192. I think this answer is expected.
> I think the "get_data_alignment" may be have a bug, because pre_pad is calculated by alignment.
> Looking forward to your answer.
> 
> Detail
> Before modify:
> 2017-11-03 14:20:54.625773 7fd32d7fa700 10 journal  len 4196188 -> 4202496 (head 40 pre_pad 4046 bl 4196188 post_pad 2182 tail 40) (bl alignment 4086)
> 
> 2017-11-03 14:20:54.625778 7fd32d7fa700 10 journal before0off:0len:40     head
> 2017-11-03 14:20:54.625779 7fd32d7fa700 10 journal before1off:0len:4046   pre_pad
> 
> 2017-11-03 14:20:54.625780 7fd32d7fa700 10 journal before2off:0len:10     bl have 19 ptrs
> 2017-11-03 14:20:54.625780 7fd32d7fa700 10 journal before3off:0len:4      <--------    important, not align 
> 2017-11-03 14:20:54.625781 7fd32d7fa700 10 journal before4off:0len:4194304  <--------   this will rebuild
> 2017-11-03 14:20:54.625781 7fd32d7fa700 10 journal before5off:4len:13
> 2017-11-03 14:20:54.625782 7fd32d7fa700 10 journal before6off:0len:256
> 2017-11-03 14:20:54.625782 7fd32d7fa700 10 journal before7off:0len:18
> 2017-11-03 14:20:54.625783 7fd32d7fa700 10 journal before8off:17len:15
> 2017-11-03 14:20:54.625783 7fd32d7fa700 10 journal before9off:0len:31
> 2017-11-03 14:20:54.625784 7fd32d7fa700 10 journal before10off:32len:43
> 2017-11-03 14:20:54.625785 7fd32d7fa700 10 journal before11off:0len:4
> 2017-11-03 14:20:54.625785 7fd32d7fa700 10 journal before12off:0len:175
> 2017-11-03 14:20:54.625786 7fd32d7fa700 10 journal before13off:4len:4
> 2017-11-03 14:20:54.625787 7fd32d7fa700 10 journal before14off:75len:13
> 2017-11-03 14:20:54.625787 7fd32d7fa700 10 journal before15off:0len:863
> 2017-11-03 14:20:54.625788 7fd32d7fa700 10 journal before16off:10len:4
> 2017-11-03 14:20:54.625788 7fd32d7fa700 10 journal before17off:0len:72
> 2017-11-03 14:20:54.625789 7fd32d7fa700 10 journal before18off:72len:72
> 2017-11-03 14:20:54.625790 7fd32d7fa700 10 journal before19off:144len:72
> 2017-11-03 14:20:54.625790 7fd32d7fa700 10 journal before20off:14len:215
> 
> 2017-11-03 14:20:54.625791 7fd32d7fa700 10 journal before21off:0len:2182   post_pad
> 2017-11-03 14:20:54.625791 7fd32d7fa700 10 journal before22off:40len:40    head
> 
> After rebuild, the result is : a big ptr, will realloc memory is 4202496
> 2017-11-03 14:20:54.627251 7fd32d7fa700 10 journal after0off:0len:4202496
> 
> If adjust pre_pad to 4042，only realloc memory 8192. after rebuild, the list have 3 ptrs, 4096 , 4194304, 4096.

Yes--this is what is supposed to happen.  What exactly is your code 
change?

Thanks!
sage


> the result is :
> 2017-11-03 14:43:35.032958 7f322ffff700 10 journal  len 4196188 -> 4202496 (head 40 pre_pad 4042 bl 4196188 post_pad 2186 tail 40) (bl alignment 4086)
> 2017-11-03 14:43:35.032965 7f322ffff700 10 journal before0off:0len:40
> 2017-11-03 14:43:35.032967 7f322ffff700 10 journal before1off:0len:4042  <-------  I modify the pre_pad from 4046 to 4042
> 
> 2017-11-03 14:43:35.032968 7f322ffff700 10 journal before2off:0len:10
> 2017-11-03 14:43:35.032970 7f322ffff700 10 journal before3off:0len:4
> 2017-11-03 14:43:35.032971 7f322ffff700 10 journal before4off:0len:4194304  <---------  this will not rebuild
> 2017-11-03 14:43:35.032972 7f322ffff700 10 journal before5off:4len:13
> 2017-11-03 14:43:35.032973 7f322ffff700 10 journal before6off:0len:256
> 2017-11-03 14:43:35.032974 7f322ffff700 10 journal before7off:0len:18
> 2017-11-03 14:43:35.032976 7f322ffff700 10 journal before8off:17len:15
> 2017-11-03 14:43:35.032977 7f322ffff700 10 journal before9off:0len:31
> 2017-11-03 14:43:35.032978 7f322ffff700 10 journal before10off:32len:43
> 2017-11-03 14:43:35.032979 7f322ffff700 10 journal before11off:0len:4
> 2017-11-03 14:43:35.032980 7f322ffff700 10 journal before12off:0len:175
> 2017-11-03 14:43:35.032982 7f322ffff700 10 journal before13off:4len:4
> 2017-11-03 14:43:35.032983 7f322ffff700 10 journal before14off:75len:13
> 2017-11-03 14:43:35.032984 7f322ffff700 10 journal before15off:0len:863
> 2017-11-03 14:43:35.032985 7f322ffff700 10 journal before16off:10len:4
> 2017-11-03 14:43:35.032986 7f322ffff700 10 journal before17off:0len:72
> 2017-11-03 14:43:35.032987 7f322ffff700 10 journal before18off:72len:72
> 2017-11-03 14:43:35.032988 7f322ffff700 10 journal before19off:144len:72
> 2017-11-03 14:43:35.032990 7f322ffff700 10 journal before20off:14len:215
> 
> 2017-11-03 14:43:35.032991 7f322ffff700 10 journal before21off:0len:2186
> 2017-11-03 14:43:35.032992 7f322ffff700 10 journal before22off:40len:40
> 2017-11-03 14:43:35.032993 7f322ffff700 10 journal prepare_entry rebuild start[Transaction(0x7f321c004910)]ebl length 4202496
> 2017-11-03 14:43:35.033023 7f322ffff700 10 journal after0off:0len:4096
> 2017-11-03 14:43:35.033025 7f322ffff700 10 journal after1off:0len:4194304   
> 2017-11-03 14:43:35.033026 7f322ffff700 10 journal after2off:0len:4096
> 2017-11-03 14:43:35.033027 7f322ffff700 10 journal [lh debug]prepare_entry rebuild end[Transaction(0x7f321c004910)]rebuild size 8192
> --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> -----邮件原件-----
> 发件人: Sage Weil [mailto:sage@newdream.net] 
> 发送时间: 2017年10月25日 20:05
> 收件人: liuhao 13701
> 抄送: 'ceph-devel@vger.kernel.org'
> 主题: Re: reply: about filestore->journal->rebuild_align
> 
> On Wed, 25 Oct 2017, Liuhao wrote:
> > Thanks for your reply.
> > 
> > >Is this a CephFS workload?
> > >The alignment is confusing because it's aligning to the object offset.  So if you're writing 200 bytes into a file, you're 200 bytes into the first object, and the padding will be something like 200 - header size.
> > 
> > Yes, this is cephFS。
> > When I use rados bench to test, log info is same,so I think no matter what is used in upper layer(no matter cephFS or rbd ).
> > ----------------------------------------------------------------------
> > ----------------------------------------------------------------------
> > ----------------------------------------------------------------------
> > -----------------
> > 
> > In func "FileJournal::prepare_entry",  "data_align" is used to make 
> > header to 4K aligned
> >  
> > Detail code:
> > h.pre_pad = ((unsigned int)data_align - (unsigned int)head_size) & 
> > ~CEPH_PAGE_MASK;
> > 
> > how to get data_align? 
> >    1. largest_data_off_in_tbl is important.
> >    2. FileStore::_do_transaction -> _build_actions_from_tbl -> write(cid, oid, off, len, bl)
> >    3. data.largest_data_off_in_tbl = tbl.length() + sizeof(__u32);  // 
> > we are about to
> > 
> > I think a transaction have many op, and "largest_data_off_in_tbl" is 
> > the largest op length, and use largest_data_off_in_tbl as alignment Is that so?
> 
> Correct. If there is, say, a small 4k write and a 1mb write in the same transaction, we want the alignment of the 1mb write so that that buffer doesn't have to be copied around to get properly alignment for direct-io.
> 
> sage
> 
> 
> > Looking forward to your answer.
> > 
> > ----------------------------------------------------------------------
> > -------------------------
> > 发件人: Sage Weil [mailto:sage@newdream.net]
> > 发送时间: 2017年10月24日 10:32
> > 收件人: liuhao 13701
> > 抄送: 'ceph-devel@vger.kernel.org'
> > 主题: Re: about filestore->journal->rebuild_align
> > 
> > 
> > 
> > On Tue, 24 Oct 2017, Liuhao wrote:
> > 
> > > Hi, lister:
> > > I use ceph’version 10.2.0
> > > 
> > > Analysis FileJournal::prepare_entry，when prepare journal
> > > bufferlist，it’s divided into 5 parts：head  pre_pad  data  post_pad 
> > > head Then reuild for buffer list to 4K align。rebuild_aligned 
> > > remalloc 4K aligned memory。（each 4K aligned memory is as small as 
> > > possible）
> > > 
> > > Detailed code：
> > > FileJournal::prepare_entry(vector<ObjectStore::Transaction>& tls,
> > > bufferlist* tbl)
> > >          Encode for transaction  ::encode(*p, bl);
> > > 　　ebl.append((const char*)&h, sizeof(h));
> > 
> > This copies into the bufferlist::append_buffer, which is a 4k aligned page.
> > 
> > > 　　ebl.push_back(buffer::create_static(h.pre_pad, zero_buf));
> > 
> > This should be ebl.append_zeros(h.pre_pad);
> > 
> > > 　　ebl.claim_append(bl, buffer::list::CLAIM_ALLOW_NONSHAREABLE); // 
> > > potential zero-copy
> > 
> > This does not, however.  We could probably change this so that if
> > bl.length() < something we copy into the buffer here instead of doing a rebuild later.
> > 
> > > 　　ebl.push_back(buffer::create_static(h.post_pad, zero_buf));
> > 
> > Here too.
> > 
> > > 　　ebl.append((const char*)&h, sizeof(h));
> > > 　　ret = ebl.rebuild_aligned(CEPH_DIRECTIO_ALIGNMENT);
> > > 　　
> > > question:
> > > before rebuild_aligned，as many ptr is aligned as 4K，so you can apply less memory.is it?
> > > head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40  total:4K*1026 
> > > rebuild_aligned will remalloc memory 4K*1026, all need rebuild
> > 
> > IIRC it's supposed to only rebuild the unaligned buffers.  So the header and padding will get rebuilt, but if the buffer bl is already aligned it will be untouched.  This is normally the case for large writes as the messenger takes care to read the data payload into memory with the correct alignment.
> > 
> >  
> > > Detail log info:
> > > In code, this log message caught my attention，the log information of these 5 valuse is not expected.
> > > 
> > > dout(10) << " len " << bl.length() << " -> " << size  << " (head " 
> > > << head_size << " pre_pad " << h.pre_pad
> > >        << " bl " << bl.length() << " post_pad " << post_pad << " tail " << head_size << ")"
> > >        << " (bl alignment " << data_align << ")" << dendl;
> > > 
> > > 2017-10-17 19:50:28.721922 7f21d73fe700 10 journal  len 4196233 ->
> > > 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl 
> > > alignment 2776)
> > > 2017-10-17 19:50:28.873261 7f21ccfff700 10 journal  len 4196131 ->
> > > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > > alignment 4086)
> > > 2017-10-17 19:50:28.897520 7f21d43ff700 10 journal  len 4196131 ->
> > > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > > alignment 4086)
> > > 2017-10-17 19:50:28.974811 7f21cf800700 10 journal  len 4196131 ->
> > > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > > alignment 4086)
> > > 2017-10-17 19:50:29.013940 7f21ccfff700 10 journal  len 4196215 ->
> > > 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl 
> > > alignment 2794)
> > > 2017-10-17 19:50:29.292165 7f21ce3ff700 10 journal  len 4196215 ->
> > > 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl 
> > > alignment 2794)
> > > 2017-10-17 19:50:29.311296 7f21cf800700 10 journal  len 4196233 ->
> > > 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl 
> > > alignment 2776)
> > > 2017-10-17 19:50:29.416240 7f21d43ff700 10 journal  len 4196215 ->
> > > 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl 
> > > alignment 2794)
> > > 2017-10-17 19:50:30.111561 7f21cc7fe700 10 journal  len 4196131 ->
> > > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > > alignment 4086)
> > > 2017-10-17 19:50:30.444729 7f21d23ff700 10 journal  len 4196131 ->
> > > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > > alignment 4086)
> > > 2017-10-17 19:50:30.448686 7f21ccfff700 10 journal  len 4196233 ->
> > > 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl 
> > > alignment 2776)
> > > 2017-10-17 19:50:30.559626 7f21d43ff700 10 journal  len 4196131 ->
> > > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > > alignment 4086)
> > > 2017-10-17 19:50:30.592541 7f21d63fe700 10 journal  len 4196233 ->
> > > 4202496 (head 40 pre_pad 2736 bl 4196233 post_pad 3447 tail 40) (bl 
> > > alignment 2776)
> > > 2017-10-17 19:50:30.599527 7f21cb7ff700 10 journal  len 4196215 ->
> > > 4202496 (head 40 pre_pad 2754 bl 4196215 post_pad 3447 tail 40) (bl 
> > > alignment 2794)
> > > 2017-10-17 19:50:30.613123 7f21d13ff700 10 journal  len 4196131 ->
> > > 4202496 (head 40 pre_pad 4046 bl 4196131 post_pad 2239 tail 40) (bl 
> > > alignment 4086)
> > 
> > Is this a CephFS workload?
> > 
> > The alignment is confusing because it's aligning to the object offset.  So if you're writing 200 bytes into a file, you're 200 bytes into the first object, and the padding will be something like 200 - header size.
> > 
> > sage
> > N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j ??f???h??????w???
> ???j:+v???w???????? ????zZ+???????j"????i
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-722012086-1509710948=:23234--
