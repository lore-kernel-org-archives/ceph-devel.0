From: Daniel Rolfe <daniel.rolfe.au@gmail.com>
Subject: Re: [ceph-calamari] Calamari 1.4
Date: Sat, 20 Feb 2016 12:32:26 +1100
Message-ID: <133B26F9-D7EA-4F08-BC3C-72676C24C4E3@gmail.com>
References: <CABq-AySXr9TPruUTB_6V986XGRGaZAETV1djmsYTCTGf2ssPyA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33316 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1428164AbcBTBcb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Feb 2016 20:32:31 -0500
Received: by mail-pa0-f51.google.com with SMTP id fl4so59158729pad.0
        for <ceph-devel@vger.kernel.org>; Fri, 19 Feb 2016 17:32:31 -0800 (PST)
In-Reply-To: <CABq-AySXr9TPruUTB_6V986XGRGaZAETV1djmsYTCTGf2ssPyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Meno <gmeno@redhat.com>
Cc: ceph-calamari@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

Hi Gregory , 

Have you considered doing away with the graphite server in favor for another metrics db like influxdb 

Just doesn't make sense to install all the graphite dependencies just to pull metric data

Plus do we really need two web interfaces i.e calamari web and graphite web

Just my thoughts

Regards Daniel

> On 20 Feb 2016, at 12:14 PM, Gregory Meno <gmeno@redhat.com> wrote:
> 
> Coming soon to a jewel near you.
> 
> What is it:
> 
> Calamari is a REST API written in python. It seeks to give API
> endpoints like /cluster,
> /pool, and /osd and unsurprisingly allow HTTP requests to inspect and
> modify the resources a Ceph cluster provides. It simplifies access to
> the control-plane by making it available across the network.
> 
> What is changing from the calamari I knew:
> Calamari is going on a diet. We're shedding dependencies on saltstack.
> The new version will be able to be run along-side Ceph Monitor
> processes on the monitor nodes.  Where before calamari sought to place
> agents on all nodes on the clusters it managed and monitored;  we now
> only care about the cluster we're setup on
> 
> What is staying the same:
> The API -- http://calamari.readthedocs.org/en/latest/calamari_rest/index.html
> This is really the part I'm most excited about. If you've used
> calamari in the past I am committed to delivering compatibility in
> this release
> 
> 
> How can I try it out:
> * note this is still development code -- don't put it on production clusters
> * http://calamari.readthedocs.org/en/latest/development/dev_env.html#using-vagrant
> * release candidate packages will be available soon
> 
> 
> How can I help:
> * Contribute doc improvements
> * File bugs in https://github.com/ceph/calamari/issues
> * Fix bugs :)
> * help with packaging
> * contribute to the future direction by discussing this on the mailing
> list -- ceph-calamari@lists.ceph.com
> 
> regards,
> Gregory
> _______________________________________________
> ceph-calamari mailing list
> ceph-calamari@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-calamari-ceph.com
