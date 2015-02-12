From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: using radosgw with mod_proxy_fcgi
Date: Thu, 12 Feb 2015 11:07:51 -0700
Message-ID: <54DCEBF7.9080708@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF915554B70A@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbbBLSH6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Feb 2015 13:07:58 -0500
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF915554B70A@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/11/2015 05:21 PM, Deneau, Tom wrote:
> I am running on a platform (aarch64) for which there are no
> pre-built binaries of the ceph patched apache and the ceph patched
> mod_fastcgi.

Hi Tom,

The ceph-patched Apache had numerous outstanding CVEs, and I discourage
users from running it any more. The distro-supplied Apache should be
suitable. We're still working to update our docs regarding this.

What distribution are you running on aarch64, by the way? Dan or I are
probably the ones who are going to be packaging mod_proxy_fcgi for
Apache 2.2, so I'm curious to know what users are running.

- Ken
