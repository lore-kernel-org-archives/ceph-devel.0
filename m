From: Wido den Hollander <wido@widodh.nl>
Subject: Re: What's the default data dir for radosgw?
Date: Wed, 15 Aug 2012 13:18:27 +0200
Message-ID: <502B8583.5070807@widodh.nl>
References: <CAMmJxtL24JkuYUNo5SPRArXoq0yF=i6Gkzu0SXjP=z+5W_CO=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:41274 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab2HOLSf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Aug 2012 07:18:35 -0400
In-Reply-To: <CAMmJxtL24JkuYUNo5SPRArXoq0yF=i6Gkzu0SXjP=z+5W_CO=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On 08/15/2012 12:21 PM, John Axel Eriksson wrote:
> I found somewhere that it's supposed to be
> /var/lib/ceph/radosgw/ceph-$id. Ok in my case I guess that would mean:
> /var/lib/ceph/radosgw/ceph-client.radosgw.gateway would that be
> correct? Since I need to store the keyring in that directory for
> example and I want to use the defaults.
>

I checked the source (common/config_opts.h) for you and it says:

OPTION(rgw_data, OPT_STR, "/var/lib/ceph/radosgw/$cluster-$id")

By default the variable cluster is "ceph", so your path would be:

/var/lib/ceph/radosgw/ceph-radosgw.gateway

$name = client.radosgw.gateway
$id = radosgw.gateway

I fetched this from the old Wiki [0]:

The following variable substitutions allow you to define many options 
generically in [global] or the daemon type section (e.g., [osd]):

* $name - daemon name (e.g. 'osd.2', 'mds.foo', 'mon.1')
* $type - daemon type (e.g. 'osd', 'mds', 'mon')
* $id or $num - daemon number or name (e.g. '2', 'foo', '1')

Wido

[0]: http://ceph.com/wiki/Cluster_configuration

> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

