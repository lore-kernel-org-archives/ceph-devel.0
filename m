From: Samuel Just <sam.just@inktank.com>
Subject: Re: dumpling integration : valgrind leak
Date: Fri, 30 Jan 2015 07:35:00 -0800
Message-ID: <CA+4uBUZR3Dvy5gszM2pOVuLsjDGAKdhRo8YLnzaWg-HOEWgcbw@mail.gmail.com>
References: <54CB9C78.5070504@dachary.org>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:54411 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbbA3PfB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 10:35:01 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so36905912lbi.1
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 07:35:00 -0800 (PST)
In-Reply-To: <54CB9C78.5070504@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Yeah, that's probably new.
-Sam

On Fri, Jan 30, 2015 at 7:00 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> I stumbled upon what seems to be a leak at http://pulpito.ceph.com/lo=
ic-2015-01-29_15:41:06-rados-dumpling-backports---basic-multi/730305/ a=
nd the valgrind xml file is at http://tracker.ceph.com/attachments/down=
load/1610/v.txt
>
>     <text>612 (584 direct, 28 indirect) bytes in 1 blocks are definit=
ely lost in loss record 268 of 287</text>
>       <fn>operator new(unsigned long)</fn>
>       <fn>ReplicatedPG::get_object_context(hobject_t const&amp;, bool=
)</fn>
>       <line>4585</line>
>       <fn>ReplicatedPG::find_object_context(hobject_t const&amp;, Obj=
ectContext**, bool, snapid_t*)</fn>
>       <line>4658</line>
>       <fn>ReplicatedPG::do_op(std::tr1::shared_ptr&lt;OpRequest&gt;)<=
/fn>
>       <line>835</line>
>       <fn>PG::do_request(std::tr1::shared_ptr&lt;OpRequest&gt;, Threa=
dPool::TPHandle&amp;)</fn>
>       <line>1455</line>
>       <fn>OSD::dequeue_op(boost::intrusive_ptr&lt;PG&gt;, std::tr1::s=
hared_ptr&lt;OpRequest&gt;, ThreadPool::TPHandle&amp;)</fn>
>       <line>7169</line>
>       <fn>OSD::OpWQ::_process(boost::intrusive_ptr&lt;PG&gt;, ThreadP=
ool::TPHandle&amp;)</fn>
>       <line>7141</line>
>       <fn>ThreadPool::WorkQueueVal&lt;std::pair&lt;boost::intrusive_p=
tr&lt;PG&gt;, std::tr1::shared_ptr&lt;OpRequest&gt; &gt;, boost::intrus=
ive_ptr&lt;PG&gt; &gt;::_void_process(void*, ThreadPool::TPHandle&amp;)=
</fn>
>       <line>191</line>
>       <fn>ThreadPool::worker(ThreadPool::WorkThread*)</fn>
>       <line>128</line>
>       <fn>ThreadPool::WorkThread::entry()</fn>
>       <line>318</line>
>       <fn>start_thread</fn>
>       <line>312</line>
>       <fn>clone</fn>
>       <line>111</line>
>
> A quick grep of get_object_context in redmine does not hit. Does it r=
ing a bell ?
>
> Cheers
>
> dumpling backport inventory: http://tracker.ceph.com/issues/10560
> ticket: http://tracker.ceph.com/issues/10697
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
