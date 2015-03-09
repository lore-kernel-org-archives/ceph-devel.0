From: Mark Nelson <mnelson@redhat.com>
Subject: Re: packages on download.ceph.com
Date: Mon, 09 Mar 2015 14:35:33 -0500
Message-ID: <54FDF605.9000302@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91555668ED@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52116 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbbCITfk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Mar 2015 15:35:40 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91555668ED@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 03/09/2015 02:06 PM, Deneau, Tom wrote:
> I'm trying to gather information on what it would take to get packages
> for an architecture other than x86_64 up on http://download.ceph.com

What we've done in the past for certain non-X86 architectures (such as 
ARM) is to get build nodes in place that can be used with our gitbuilder 
setup to continuously make development builds:

http://www.ceph.com/gitbuilder.cgi

Which get put here:

http://gitbuilder.ceph.com/

Usually the problem is two fold:  Someone's time to set it up, and 
making sure we have enough (or fast enough) build systems for that 
architecture to keep up.

Mark

>
> -- Tom Deneau, AMD
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
