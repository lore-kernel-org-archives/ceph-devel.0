From: Sage Weil <sage@inktank.com>
Subject: Re: osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid <
 tid)
Date: Thu, 14 Feb 2013 09:18:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302140916260.19760@cobra.newdream.net>
References: <511CFDDF.6080406@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40755 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903Ab3BNRSG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 12:18:06 -0500
In-Reply-To: <511CFDDF.6080406@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

Hi Martin-

On Thu, 14 Feb 2013, Martin Mailand wrote:
> Hi List,
> 
> I get reproducible this assertion, how can I help to debug it?

Can you describe the workload?  Are the OSDs also running 0.56.2(+)?  Any 
other activity on the server side (data migration, OSD failure, etc.) that 
may have contributed?

We just reopened http://tracker.ceph.com/issues/2947 to track this.  I'm 
working on reproducing it now as well.

Thanks!
sage



> 
> 
> -martin
> 
> (Lese Datenbank ... 52246 Dateien und Verzeichnisse sind derzeit
> installiert.)
> Vorbereitung zum Ersetzen von linux-firmware 1.79 (durch
> .../linux-firmware_1.79.1_all.deb) ...
> Ersatz f?r linux-firmware wird entpackt ...
> osdc/ObjectCacher.cc: In function 'void
> ObjectCacher::bh_write_commit(int64_t, sobject_t, loff_t, uint64_t,
> tid_t, int)' thread 7f72b7fff700 time 2013-02-14 16:04:48.867285
> osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid < tid)
>  ceph version 0.56.2 (586538e22afba85c59beda49789ec42024e7a061)
>  1: (ObjectCacher::bh_write_commit(long, sobject_t, long, unsigned long,
> unsigned long, int)+0xd68) [0x7f72d4050848]
>  2: (ObjectCacher::C_WriteCommit::finish(int)+0x6b) [0x7f72d405742b]
>  3: (Context::complete(int)+0xa) [0x7f72d400f9ba]
>  4: (librbd::C_Request::finish(int)+0x85) [0x7f72d403f145]
>  5: (Context::complete(int)+0xa) [0x7f72d400f9ba]
>  6: (librbd::rados_req_cb(void*, void*)+0x47) [0x7f72d40241b7]
>  7: (librados::C_AioSafe::finish(int)+0x1d) [0x7f72d33db16d]
>  8: (Finisher::finisher_thread_entry()+0x1c0) [0x7f72d3444e50]
>  9: (()+0x7e9a) [0x7f72d03c7e9a]
>  10: (clone()+0x6d) [0x7f72d00f4cbd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> Aborted
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
