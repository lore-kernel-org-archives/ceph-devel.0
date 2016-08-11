From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD not coming back up again
Date: Thu, 11 Aug 2016 16:36:36 +0200
Message-ID: <57ca8142-b499-2ccb-7b19-d455b4f8318e@digiware.nl>
References: <bdb93e87-8338-e485-a68d-f988d00f6785@digiware.nl>
 <453729567.2335.1470896803201@ox.pcextreme.nl>
 <5727f9c9-57e0-6256-dbd7-30b73c6feaec@digiware.nl>
 <1788022033.2389.1470915881301@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:38318 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbcHKOgp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 10:36:45 -0400
In-Reply-To: <1788022033.2389.1470915881301@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 11-8-2016 13:44, Wido den Hollander wrote:
> Could be, but the log line which is interesting:
> 
> 2016-08-11 12:06:16.473351 b69c480 10 osd.0 178 handle_osd_ping osd.2
> 127.0.0.1:6811/13222 says i am down in 178

So I've augmented the code a bit:

  case MOSDPing::YOU_DIED:
    dout(10) << "handle_osd_ping " << m->get_source_inst()
             << " says i am down in " << m->map_epoch << dendl;
    dout(10) << "handle_osd_ping subscribing to: " << curmap->get_epoch()+1
             << dendl;
    osdmap_subscribe(curmap->get_epoch()+1, false);
    break;

And we go into odsmap_subscribe, which I augmented too:
void OSD::osdmap_subscribe(version_t epoch, bool force_request)
{
  OSDMapRef osdmap = service.get_osdmap();
  if (osdmap->get_epoch() >= epoch) {
    dout(10) << __func__ << " subscribing to: " << epoch
             << " but osdmap already has: " << osdmap->get_epoch()
             << dendl;
    return;
  }

  if (monc->sub_want_increment("osdmap", epoch, CEPH_SUBSCRIBE_ONETIME)
 		||force_request) {
    dout(10) << __func__ << " renewing subscription" << dendl;
    monc->renew_subs();
  }
}

If I run with force_request = false, then this call does absolutely
nothing... Neither if's trigger
If I set force_request = true (expecting it to fetch the whole map),
that does not do much either.
It reports:
	monclient: renew_subs - empty


So either this path is never/rarely used, or is not the solution to the
problem.

--WjW

