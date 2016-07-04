From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cmake
Date: Mon, 4 Jul 2016 11:05:07 +0200
Message-ID: <0ba08c31-8c9e-a483-6c5b-07ce9b6b5495@digiware.nl>
References: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:50828 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932715AbcGDJFX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jul 2016 05:05:23 -0400
In-Reply-To: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 27-6-2016 19:50, Sage Weil wrote:
> We are switching from autotools to cmake on the master branch. Any 
> builds done post-jewel will be cmake and not autotools based.  Jewel and 
> older releases will still be built with autotools the old way.

Hi Sage,

Question about Cmake versions....

On FreeBSD cmake is version 3.5.2
My Centos box has 2.8.11

If there any "minimum" requirements here??

--WjW



