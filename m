From: Gregory Meno <gmeno@redhat.com>
Subject: Re: [ceph-calamari] Calamari 1.4
Date: Mon, 22 Feb 2016 11:10:35 -0800
Message-ID: <CABq-AyTQwkEZREf8u-m=h-aEYBBKTB6+hPqi_XQ=_JbyddvQfA@mail.gmail.com>
References: <CABq-AySXr9TPruUTB_6V986XGRGaZAETV1djmsYTCTGf2ssPyA@mail.gmail.com>
	<133B26F9-D7EA-4F08-BC3C-72676C24C4E3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35067 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbcBVTKg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Feb 2016 14:10:36 -0500
Received: by mail-yw0-f182.google.com with SMTP id g127so127335226ywf.2
        for <ceph-devel@vger.kernel.org>; Mon, 22 Feb 2016 11:10:35 -0800 (PST)
In-Reply-To: <133B26F9-D7EA-4F08-BC3C-72676C24C4E3@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Rolfe <daniel.rolfe.au@gmail.com>, Phillip Carinhas <pcarinhas@zenoss.com>
Cc: ceph-calamari@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 19, 2016 at 5:32 PM, Daniel Rolfe <daniel.rolfe.au@gmail.com> wrote:
> Hi Gregory ,
>
> Have you considered doing away with the graphite server in favor for another metrics db like influxdb
>
> Just doesn't make sense to install all the graphite dependencies just to pull metric data
>
> Plus do we really need two web interfaces i.e calamari web and graphite web
>
> Just my thoughts
>
> Regards Daniel
>
>> On 20 Feb 2016, at 12:14 PM, Gregory Meno <gmeno@redhat.com> wrote:
>>
>> Coming soon to a jewel near you.
>>
>> What is it:
>>
>> Calamari is a REST API written in python. It seeks to give API
>> endpoints like /cluster,
>> /pool, and /osd and unsurprisingly allow HTTP requests to inspect and
>> modify the resources a Ceph cluster provides. It simplifies access to
>> the control-plane by making it available across the network.
>>
>> What is changing from the calamari I knew:
>> Calamari is going on a diet. We're shedding dependencies on saltstack.
>> The new version will be able to be run along-side Ceph Monitor
>> processes on the monitor nodes.  Where before calamari sought to place
>> agents on all nodes on the clusters it managed and monitored;  we now
>> only care about the cluster we're setup on
>>
>> What is staying the same:
>> The API -- http://calamari.readthedocs.org/en/latest/calamari_rest/index.html
>> This is really the part I'm most excited about. If you've used
>> calamari in the past I am committed to delivering compatibility in
>> this release
>>
>>
>> How can I try it out:
>> * note this is still development code -- don't put it on production clusters
>> * http://calamari.readthedocs.org/en/latest/development/dev_env.html#using-vagrant
>> * release candidate packages will be available soon
>>
>>
>> How can I help:
>> * Contribute doc improvements
>> * File bugs in https://github.com/ceph/calamari/issues
>> * Fix bugs :)
>> * help with packaging
>> * contribute to the future direction by discussing this on the mailing
>> list -- ceph-calamari@lists.ceph.com
>>
>> regards,
>> Gregory
>> _______________________________________________
>> ceph-calamari mailing list
>> ceph-calamari@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-calamari-ceph.com

Daniel,

I'm not sure I understand what you are asking. We could certainly try
to strip it down now that I'm not really expecting graphs output for a
GUI.

Graphite is really just a front-end to the data living in carbon and
reported by diamond.

The sticking point is that I believe that some are using the graphite
API that is wrapped by calamari. Phillip would you please say more
about this?

Influxdb seems promising AND I have a concern that it seems to not be
packages in any of the distros yet.

https://admin.fedoraproject.org/pkgdb/packages/?motif=influxdb*

http://packages.ubuntu.com/search?keywords=influxdb -- sure it's in
xenial but I'm not there yet

https://software.opensuse.org/package/influxdb


What do you think?

thank you,
Gregory
