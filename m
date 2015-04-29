From: Wido den Hollander <wido@42on.com>
Subject: Re: Default config value for osd_disk_thread_ioprio_class
Date: Wed, 29 Apr 2015 14:23:24 +0200
Message-ID: <5540CD3C.4080409@42on.com>
References: <5540CA47.8010201@pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:42483 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422762AbbD2MXa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Apr 2015 08:23:30 -0400
In-Reply-To: <5540CA47.8010201@pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@pcextreme.nl>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/29/2015 02:10 PM, Wido den Hollander wrote:
> Hi,
> 
> In the process of upgrading a cluster from Giant to Hammer I saw this
> on the OSD logs:
> 
> 2015-04-29 14:02:37.015454 7f887875e900 -1 osd.456 43089
> set_disk_tp_priority(22) Invalid argument:
> osd_disk_thread_ioprio_class is  but only the following values are
> allowed: idle, be or rt
> 
> That is correct, since config_opts.h says:
> 
> OPTION(osd_disk_thread_ioprio_class, OPT_STR, "") // rt realtime be
> best effort idle
> 
> It's nothing bad, but it would be nicer if we got rid of it.
> 
> What to do here? Allow "" as a config setting and then ignore it or
> set the default to rt, be or idle?
> 

I see there actually is a check for it:

  if (cct->_conf->osd_disk_thread_ioprio_class.empty() ||
      cct->_conf->osd_disk_thread_ioprio_priority < 0)
    return;

So empty() does not return True there while it should since the setting
is set to ""?

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
