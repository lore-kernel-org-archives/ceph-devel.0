From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: firewall questions
Date: Thu, 21 May 2015 09:36:17 -0600
Message-ID: <555DFB71.6050602@redhat.com>
References: <555CE992.10703@redhat.com> <alpine.DEB.2.00.1505201551450.23818@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54237 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093AbbEUPgS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 May 2015 11:36:18 -0400
In-Reply-To: <alpine.DEB.2.00.1505201551450.23818@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/20/2015 04:53 PM, Sage Weil wrote:
>> 2. I talked recently with Sam about the possible ports an OSD could use,
>> and our conversation made me think that our firewall docs for OSDs and
>> MDSs might need to be updated: http://tracker.ceph.com/issues/11688
>>
>> Currently the docs say "calculate the number of OSDs or MDSs you're
>> running and that will tell you what ports to open". That makes it hard
>> to write a service definition for firewalld, since those are just a list
>> of static ports.
> 
> Yeah, I'm afraid it should just be teh full range we allow... I think 
> 6800-7100 by default?

src/common/config_opts.h from master says:

  OPTION(ms_bind_port_min, OPT_INT, 6800)
  OPTION(ms_bind_port_max, OPT_INT, 7300)

I think that would mean we'd want to open 6800-7300 by default?

And for this firewalld service name, I was thinking of naming this
6800-7300 rule "ceph", since it encompasses both the OSD and MDS
services. Does that name sound ok? (And I'd name the 6789 rule "ceph-mon".)

- Ken
