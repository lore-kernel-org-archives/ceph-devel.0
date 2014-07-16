From: Gregory Farnum <greg@inktank.com>
Subject: Re: [RFC][PATCH] osd: Add local_connection to fast_dispatch in func _send_boot.
Date: Wed, 16 Jul 2014 12:40:50 -0700
Message-ID: <CAPYLRzhx0JUPYV8Qbv0cCUxH1Wr_1Zm7s=N3YpF-_6Qit_SWWA@mail.gmail.com>
References: <6AA21C22F0A5DA478922644AD2EC308C887C60@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:61101 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaGPTkv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jul 2014 15:40:51 -0400
Received: by mail-qc0-f178.google.com with SMTP id x3so1225356qcv.23
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jul 2014 12:40:50 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C887C60@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm looking at this and getting a little confused. Can you provide a
log of the crash occurring? (preferably with debug_ms=20,
debug_osd=20)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Sun, Jul 13, 2014 at 8:17 PM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
> When do ec-read, i met a bug which was occured 100%. The messages are:
> 2014-07-14 10:03:07.318681 7f7654f6e700 -1 osd/OSD.cc: In function
> 'virtual void OSD::ms_fast_dispatch(Message*)' thread 7f7654f6e700 time
> 2014-07-14 10:03:07.316782 osd/OSD.cc: 5019: FAILED assert(session)
>
>  ceph version 0.82-585-g79f3f67 (79f3f6749122ce2944baa70541949d7ca75525e6)
>  1: (OSD::ms_fast_dispatch(Message*)+0x286) [0x6544b6]
>  2: (DispatchQueue::fast_dispatch(Message*)+0x56) [0xb059d6]
>  3: (DispatchQueue::run_local_delivery()+0x6b) [0xb08e0b]
>  4: (DispatchQueue::LocalDeliveryThread::entry()+0xd) [0xa4a5fd]
>  5: (()+0x8182) [0x7f7665670182]
>  6: (clone()+0x6d) [0x7f7663a1130d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
> In commit 69fc6b2b66, it enable fast_dispatch on local connections and
> it will add local_connection to fast_dispatch in func init_local_connection.
> But if there is no fast-dispatch, the local connection can't add.
>
> If there is no clutser addr in ceph.conf, it will add local_connection
> to fast dispatch in func _send_boot because the cluster_addr is empty.
> But if there is cluster addr, local_connection can't add to fast dispatch.
>
> For ECSubRead, it send to itself by func send_message_osd_cluster so it
> will cause this bug.
>
> I don't know about hb_back/front_server_messenger. But they are in
> _send_boot like cluster_messenger, so i also modified those.
>
> Signed-off-by: Ma Jianpeng <jianpeng.ma@intel.com>
> ---
>  src/osd/OSD.cc | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
> index 52a3839..75b294b 100644
> --- a/src/osd/OSD.cc
> +++ b/src/osd/OSD.cc
> @@ -3852,29 +3852,37 @@ void OSD::_send_boot()
>  {
>    dout(10) << "_send_boot" << dendl;
>    entity_addr_t cluster_addr = cluster_messenger->get_myaddr();
> +  Connection *local_connection = cluster_messenger->get_loopback_connection().get();
>    if (cluster_addr.is_blank_ip()) {
>      int port = cluster_addr.get_port();
>      cluster_addr = client_messenger->get_myaddr();
>      cluster_addr.set_port(port);
>      cluster_messenger->set_addr_unknowns(cluster_addr);
>      dout(10) << " assuming cluster_addr ip matches client_addr" << dendl;
> -  }
> +  } else if (local_connection->get_priv() == NULL)
> +      cluster_messenger->ms_deliver_handle_fast_connect(local_connection);
> +
>    entity_addr_t hb_back_addr = hb_back_server_messenger->get_myaddr();
> +  local_connection = hb_back_server_messenger->get_loopback_connection().get();
>    if (hb_back_addr.is_blank_ip()) {
>      int port = hb_back_addr.get_port();
>      hb_back_addr = cluster_addr;
>      hb_back_addr.set_port(port);
>      hb_back_server_messenger->set_addr_unknowns(hb_back_addr);
>      dout(10) << " assuming hb_back_addr ip matches cluster_addr" << dendl;
> -  }
> +  } else if (local_connection->get_priv() == NULL)
> +      hb_back_server_messenger->ms_deliver_handle_fast_connect(local_connection);
> +
>    entity_addr_t hb_front_addr = hb_front_server_messenger->get_myaddr();
> +  local_connection = hb_front_server_messenger->get_loopback_connection().get();
>    if (hb_front_addr.is_blank_ip()) {
>      int port = hb_front_addr.get_port();
>      hb_front_addr = client_messenger->get_myaddr();
>      hb_front_addr.set_port(port);
>      hb_front_server_messenger->set_addr_unknowns(hb_front_addr);
>      dout(10) << " assuming hb_front_addr ip matches client_addr" << dendl;
> -  }
> +  } else if (local_connection->get_priv() == NULL)
> +      hb_front_server_messenger->ms_deliver_handle_fast_connect(local_connection);
>
>    MOSDBoot *mboot = new MOSDBoot(superblock, service.get_boot_epoch(),
>                                   hb_back_addr, hb_front_addr, cluster_addr);
> --
> 1.9.1
>
