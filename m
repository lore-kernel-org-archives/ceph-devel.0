From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: OSD rebind connects to ports of other OSDs
Date: Tue, 20 Dec 2016 19:23:50 +0200
Message-ID: <20161220172349.GB1510@gmail.com>
References: <2b061067-e839-054e-5166-619deecfae5e@digiware.nl>
 <20161220150636.GA1510@gmail.com>
 <f1963dc8-2c2e-04bb-ea05-849e051631c2@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34526 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756478AbcLTRYe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 12:24:34 -0500
Received: by mail-lf0-f43.google.com with SMTP id y21so80753900lfa.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 09:23:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f1963dc8-2c2e-04bb-ea05-849e051631c2@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Dec 20, 2016 at 05:48:33PM +0100, Willem Jan Withagen wrote:

> First round of binds:
> 2016-12-12 23:57:37.615409 7f36c2be6940  1 -- 0.0.0.0:6800/13799
> _finish_bind bind my_inst.addr is 0.0.0.0:6800/13799
> 2016-12-12 23:57:37.615739 7f36c2be6940  1 -- 0.0.0.0:6801/13799
> _finish_bind bind my_inst.addr is 0.0.0.0:6801/13799
> 2016-12-12 23:57:37.616090 7f36c2be6940  1 -- 0.0.0.0:6802/13799
> _finish_bind bind my_inst.addr is 0.0.0.0:6802/13799
> 2016-12-12 23:57:37.616452 7f36c2be6940  1 -- 0.0.0.0:6803/13799
> _finish_bind bind my_inst.addr is 0.0.0.0:6803/13799
> 
> So that is to INADDR_ANY
> 
> rebinds:
> 2016-12-12 23:57:50.094446 7f36b5ac6700  1 -- 127.0.0.1:6812/1013799
> _finish_bind bind my_inst.addr is 127.0.0.1:6812/1013799
> 2016-12-12 23:57:50.094956 7f36b5ac6700  1 -- 127.0.0.1:6813/1013799
> _finish_bind bind my_inst.addr is 127.0.0.1:6813/1013799
> 2016-12-12 23:57:50.095477 7f36b5ac6700  1 -- 127.0.0.1:6814/1013799
> _finish_bind bind my_inst.addr is 127.0.0.1:6814/1013799
> 
> so that is on the hostname as specified in the config.
> 
> So your suggestion would be to not bind on INADDR_ANY but on the config
> hostname with the initial bind as well??

I am not familiar with rebind logic here, so it is difficult for me to
make suggestions. But I would expect that bind and rebind addresses
should be the same. Not sure it should be hostname though. In your
case for example, before rebind the osd was listening on all
interfaces, and after rebind it was listening only on loopback,
i.e. it was accessible only from the local host.

-- 
Mykola Golub
