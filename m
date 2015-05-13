From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Problems with installation httpd and mod_ssl from ceph repo
Date: Wed, 13 May 2015 17:25:43 -0600
Message-ID: <5553DD77.9060300@redhat.com>
References: <4009181431524961@web9g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42296 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137AbbEMXZp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 May 2015 19:25:45 -0400
In-Reply-To: <4009181431524961@web9g.yandex.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Butkeev Stas <staerist@ya.ru>, ceph-devel@vger.kernel.org
Cc: ceph-qa@ceph.com, ceph-maintainers@ceph.com

On 05/13/2015 07:49 AM, Butkeev Stas wrote:
> Hello everyone
> 
> I have rhel 6.5 OS.
> Today I faced with next error with dependencies.
> Initially I installed httpd and after I wanted to install mod_ssl for one. But got problem.
> Step to reproduce:
> 1) Install http


The Ceph version of httpd has several unresolved CVEs and should not be
used. Please just use the httpd packages straight from CentOS.

I think we've purged our docs of all references to installing a custom
Apache. Are you following a doc somewhere that still refers to this?

- Ken

