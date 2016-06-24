From: Ali Maredia <amaredia@redhat.com>
Subject: Re: plugin infra issues
Date: Fri, 24 Jun 2016 14:56:54 -0400 (EDT)
Message-ID: <1008095047.5820355.1466794614455.JavaMail.zimbra@redhat.com>
References: <2b706ff1-6082-e99f-135c-7d6b02a237ce@mirantis.com> <alpine.DEB.2.11.1606221557160.21827@piezo.us.to> <284db414-5822-7392-67bf-25e1a530a243@mirantis.com> <alpine.DEB.2.11.1606221701330.21827@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:52015 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcFXS44 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2016 14:56:56 -0400
In-Reply-To: <alpine.DEB.2.11.1606221701330.21827@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel@vger.kernel.org

Sage,

That sounds great to me, what would you propose we do next? 

Have do_cmake.sh create a ceph.conf that sets those paths?

-Ali 

----- Original Message -----
From: "Sage Weil" <sweil@redhat.com>
To: "Igor Fedotov" <ifedotov@mirantis.com>
Cc: ceph-devel@vger.kernel.org, amaredia@redhat.com
Sent: Wednesday, June 22, 2016 1:04:10 PM
Subject: Re: plugin infra issues

[adding ceph-devel]

On Wed, 22 Jun 2016, Igor Fedotov wrote:
> Well, having ceph.conf helps a bit. But PluginRegistry::load still appends
> plugin type (i.e. "/compressor") to the path. Hence it wouldn't work on a
> clean build IMHO...
> Another point - I'm not sure if that's a good practice to require config file
> to run the tests. IMO it's preferable to have they working properly as-is.

I think the solution to this shoudl focus on the cmake developer workflow.  
Build is in ceph.git/build/, stuff goes in lib/, and the default build 
should set the default ceph lib path to ./lib.  Or, have do_cmake.sh 
create a ceph.conf that sets these paths in a build/ceph.conf file.  
Either way, we should make sure the recommended and documented developer 
workflow (building and running via vstart, running unit tests, etc.) works 
well out of the box...

Ali, does that sound like the right way to go?

sage


> 
> 
> On 22.06.2016 18:57, Sage Weil wrote:
> > It works for me because my ./ceph.conf specifies the right dir.  If you
> > run vstart.sh this will get set up.
> > 
> > 
> > On Wed, 22 Jun 2016, Igor Fedotov wrote:
> > 
> > > Hi Sage,
> > > 
> > > as I mentioned during the syncup I faced some issues when running
> > > ceph_test_objectstore. Namely BluestoreStatFSTest fails.
> > > 
> > > The root cause is that it's unable to load snappy compressor plugin after
> > > your
> > > recent cleanup. Now store_test attempts to do the load from
> > > /usr/local/lib...
> > > folder only while previously it tried .libs/compressor one as well.
> > > 
> > > Additionally there are some other test cases that use the same mechanics
> > > to
> > > locate plugin as the one you removed from store_test. Here they are:
> > > 
> > > test/common/test_async_compressor.cc
> > > 
> > > test/compressor/test_compression_plugin.cc
> > > 
> > > test/compressor/test_compression_plugin_snappy.cc
> > > 
> > > test/compressor/test_compression_plugin_zlib.cc
> > > 
> > > 
> > > Hence the question is what's your suggestion about resolving that? As for
> > > me
> > > I'd prefer to be able to use .libs for testing somehow...
> > > 
> > > 
> > > Thanks,
> > > 
> > > Igor.
> > > 
> > > 
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
