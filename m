From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: waiting for sub ops
Date: Fri, 11 May 2012 15:25:46 +0200
Message-ID: <4FAD135A.10108@profihost.ag>
References: <4FACB96F.3050309@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35074 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab2EKNZc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 May 2012 09:25:32 -0400
In-Reply-To: <4FACB96F.3050309@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

all messages are always taling about snapc? I've no idea what this is.

Stefan

Am 11.05.2012 09:02, schrieb Stefan Priebe - Profihost AG:
> Hi,
> 
> while doing some stress testing with bonnie++ i'm seeing always these
> messages accross all osd's here is just an example for osd.2.
> 
> All machines are connected with 2x 1Gbit/s bonding mode 6 to a HP switch.
> 
> 2012-05-11 08:58:52.752057 osd.2 192.168.0.102:6801/4798 3218 : [WRN]
> old request osd_op(mds.0.1:49546 200.00000027 [write 1643206~13552]
> 1.379675e3) v4 received at 2012-05-11 08:58:22.044033 currently waiting
> for sub ops
> 2012-05-11 08:58:52.752059 osd.2 192.168.0.102:6801/4798 3219 : [WRN]
> old request osd_op(client.4108.1:28755 10000008004.00000266 [write
> 0~4194304] 0.79b497c7 snapc 1=[]) received at 2012-05-11 08:58:22.026435
> currently waiting for sub ops
> 2012-05-11 08:58:52.752061 osd.2 192.168.0.102:6801/4798 3220 : [WRN]
> old request osd_op(client.4108.1:28762 10000008004.0000026d [write
> 0~4194304] 0.493cb0d4 snapc 1=[]) received at 2012-05-11 08:58:22.191536
> currently waiting for sub ops
> 2012-05-11 08:58:52.752064 osd.2 192.168.0.102:6801/4798 3221 : [WRN]
> old request osd_op(client.4108.1:28765 10000008004.00000270 [write
> 0~4194304] 0.b2f1b144 snapc 1=[]) received at 2012-05-11 08:58:22.290388
> currently waiting for sub ops
> 2012-05-11 08:58:52.752066 osd.2 192.168.0.102:6801/4798 3222 : [WRN]
> old request osd_op(client.4108.1:28774 10000008004.00000279 [write
> 0~4194304] 0.2373c652 snapc 1=[]) received at 2012-05-11 08:58:22.392604
> currently waiting for sub ops
> 2012-05-11 08:58:52.752068 osd.2 192.168.0.102:6801/4798 3223 : [WRN]
> old request osd_op(client.4108.1:28775 10000008004.0000027a [write
> 0~4194304] 0.24a58617 snapc 1=[]) received at 2012-05-11 08:58:22.455618
> currently waiting for sub ops
> 2012-05-11 08:58:52.752070 osd.2 192.168.0.102:6801/4798 3224 : [WRN]
> old request osd_op(client.4108.1:28777 10000008004.0000027c [write
> 0~4194304] 0.1c900a76 snapc 1=[]) received at 2012-05-11 08:58:22.527086
> currently waiting for sub ops
> 2012-05-11 08:58:53.752212 osd.2 192.168.0.102:6801/4798 3225 : [WRN]
> old request osd_op(client.4108.1:28808 10000008004.0000029b [write
> 0~4194304] 0.46c529aa snapc 1=[]) received at 2012-05-11 08:58:23.252258
> currently waiting for sub ops
> 
> Stefan
