From: John Axel Eriksson <john@insane.se>
Subject: Re: What's the default data dir for radosgw?
Date: Wed, 15 Aug 2012 14:58:44 +0200
Message-ID: <CAMmJxtLxt0BC0QTKxvViXaPhduOyHKuO+_L49yHszeAsM8ZV6g@mail.gmail.com>
References: <CAMmJxtL24JkuYUNo5SPRArXoq0yF=i6Gkzu0SXjP=z+5W_CO=g@mail.gmail.com>
	<502B8583.5070807@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:60919 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab2HOM6p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Aug 2012 08:58:45 -0400
Received: by vcbfk26 with SMTP id fk26so1392380vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Aug 2012 05:58:45 -0700 (PDT)
In-Reply-To: <502B8583.5070807@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Yeah I actually figured it out through trial and error but thanks!

On Wed, Aug 15, 2012 at 1:18 PM, Wido den Hollander <wido@widodh.nl> wrote:
> On 08/15/2012 12:21 PM, John Axel Eriksson wrote:
>>
>> I found somewhere that it's supposed to be
>> /var/lib/ceph/radosgw/ceph-$id. Ok in my case I guess that would mean:
>> /var/lib/ceph/radosgw/ceph-client.radosgw.gateway would that be
>> correct? Since I need to store the keyring in that directory for
>> example and I want to use the defaults.
>>
>
> I checked the source (common/config_opts.h) for you and it says:
>
> OPTION(rgw_data, OPT_STR, "/var/lib/ceph/radosgw/$cluster-$id")
>
> By default the variable cluster is "ceph", so your path would be:
>
> /var/lib/ceph/radosgw/ceph-radosgw.gateway
>
> $name = client.radosgw.gateway
> $id = radosgw.gateway
>
> I fetched this from the old Wiki [0]:
>
> The following variable substitutions allow you to define many options
> generically in [global] or the daemon type section (e.g., [osd]):
>
> * $name - daemon name (e.g. 'osd.2', 'mds.foo', 'mon.1')
> * $type - daemon type (e.g. 'osd', 'mds', 'mon')
> * $id or $num - daemon number or name (e.g. '2', 'foo', '1')
>
> Wido
>
> [0]: http://ceph.com/wiki/Cluster_configuration
>
>> John
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
