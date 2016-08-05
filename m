From: Nathan Cutler <ncutler@suse.de>
Subject: Re: Questions about embedding Lua in the Ceph source tree
Date: Fri, 5 Aug 2016 22:10:56 +0200
Message-ID: <269194d1-395e-2288-c268-18584ee795ec@suse.de>
References: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45489 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2994643AbcHEUK7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Aug 2016 16:10:59 -0400
In-Reply-To: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> * Embedding Lua in this form makes it *impossible* for distro maintainers to
>   package Ceph

That would be very serious. How does compiling Lua as a submodule within 
Ceph make it impossible for Ceph to be packaged in a distro?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
