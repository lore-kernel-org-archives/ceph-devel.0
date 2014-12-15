From: Vit Yenukas <Vit.Yenukas@twosigma.com>
Subject: Re: Recovery long tail investigation
Date: Mon, 15 Dec 2014 17:18:35 +0000
Message-ID: <5F401C8095B99D4FABC1B919C1BE599A0121CBD94B@EXMBNJE1.ad.twosigma.com>
References: <548B61F5.3010305@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxl2.aoa.dmz.twosigma.com ([208.77.215.146]:40121 "EHLO
	mxl2.aoa.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaLOR0a convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 12:26:30 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <ldachary@redhat.com>
Cc: Sheldon Mustard <sheldon.mustard@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

It was set to default (i.e. == 10 for v0.80.5 as well, IIRC) - we didn't 
think that it'd help the "long tail" problem to tweak it.

On 12/12/2014 04:45 PM, Loic Dachary wrote:

> In the context of http://tracker.ceph.com/issues/9566 do you remember what the value of max_backfills was ? https://github.com/ceph/ceph/blob/giant/src/common/config_opts.h#L409 It probably makes a difference if it is set to 1 instead of the default.
