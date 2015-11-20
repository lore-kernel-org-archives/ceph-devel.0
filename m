From: Haomai Wang <haomaiwang@gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogam91cm5hbCBhbGlnbm1lbnQ=?=
Date: Fri, 20 Nov 2015 21:29:11 +0800
Message-ID: <CACJqLyY48OX4rLFg9xj_UxEmO24x0bx70wyJsLjGnLyM-skkCA@mail.gmail.com>
References: <019801d1236e$206f12e0$614d38a0$@com>
	<d742f6275e1645cdb02b0bad23110eec@R01UKEXCASM115.r01.fujitsu.local>
	<023e01d12373$941f1050$bc5d30f0$@com>
	<alpine.DEB.2.00.1511200339470.25088@cobra.newdream.net>
	<CACJqLybiXZC01ZDD2nUz58PmOWNBSNk01Dr6dNrnTzd6poNOLA@mail.gmail.com>
	<alpine.DEB.2.00.1511200507120.24879@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35933 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162687AbbKTN3M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 08:29:12 -0500
Received: by obdgf3 with SMTP id gf3so87021524obd.3
        for <ceph-devel@vger.kernel.org>; Fri, 20 Nov 2015 05:29:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511200507120.24879@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: changtao381 <changtao381@163.com>, =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 20, 2015 at 9:08 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 20 Nov 2015, Haomai Wang wrote:
>> On Fri, Nov 20, 2015 at 7:41 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Fri, 20 Nov 2015, changtao381 wrote:
>> >> Hi All,
>> >>
>> >> Thanks for you apply!
>> >>
>> >> If directioIO + async IO requirement that alignment, it shouldn't aligned by PAGE for each journal entry.
>> >> For it may write many entries of journal once time
>> >
>> > We also want to avoid copying the data around in memory to change the
>> > alignment.  The messenger takes care to read data off the wire into
>> > buffers with the correct alignment so that we can later use them for
>> > direct-io.
>> >
>> > If you're worried about the small io case, I think this is just a matter
>> > of setting a threshold for small ios so that we don't bother with all of
>> > the padding when the memory copy isn't that expensive.  But... given that
>> > we have a header *and* footer in the journal format and almost all IOs are
>> > 4k multiples I think it'd save you a single 4k block at most.
>> >
>> > (Also, I thought we already did something like this, but perhaps not!)
>>
>> Hmm, based on our recently test, the data from messenger is aligned.
>> But the encoded data(pglog, transaction) will make thing worse, like
>> PR(https://github.com/ceph/ceph/pull/6368) solved, we even will get 14
>> ptr in the bufferlist which passed into filejournal before. So it make
>> we rebuild each time within filejournal thread. Like this
>> PR(https://github.com/ceph/ceph/pull/6484), we try to make it rebuild
>> not in filejournal thread which is single.
>
> buffer::list::rebuild_page_aligned() should only copy/rebuild ptrs that
> are unaligned, and leave aligned ones untouched.  It looks like the
> journal code is already doing this?

Yes or not, for example we have a bufferlist contains 2 ptrs, the
first is unaligned, the second is aligned. But the current impl will
ignore the second alignment fact. Look at the code:

  void buffer::list::rebuild_aligned_size_and_memory(unsigned align_size,
    unsigned align_memory)
  {
........
      list unaligned;
      unsigned offset = 0;
      do {
        /*cout << " segment " << (void*)p->c_str()
               << " offset " << ((unsigned long)p->c_str() & (align - 1))
               << " length " << p->length() << " " << (p->length() &
(align - 1))
               << " overall offset " << offset << " " << (offset & (align - 1))
      << " not ok" << std::endl;
        */
        offset += p->length();
        unaligned.push_back(*p);
        _buffers.erase(p++);
      } while (p != _buffers.end() &&
      (!p->is_aligned(align_memory) ||
       !p->is_n_align_sized(align_size) ||
       (offset % align_size)));
((((((((((((( it will check offset alignment, so won't continues after
meeting the first unalign ptr ))))))))))))))

      if (!(unaligned.is_contiguous() &&
unaligned._buffers.front().is_aligned(align_memory))) {
        ptr nb(buffer::create_aligned(unaligned._len, align_memory));
        unaligned.rebuild(nb);
        _memcopy_count += unaligned._len;
      }
      _buffers.insert(p, unaligned._buffers.front());
    }
  }


>
> sage



-- 
Best Regards,

Wheat
