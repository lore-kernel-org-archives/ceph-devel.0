From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Mon, 27 Aug 2012 20:54:20 -0700
Message-ID: <20120828035420.GB19573@splice>
References: <loom.20120827T091156-421@post.gmane.org>
 <CAC-hyiHm+-aU9pfXE_eb2Gpji2vC3U15YfBwyLMF4XsZRMWkBQ@mail.gmail.com>
 <loom.20120828T054548-835@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41841 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2H1DyZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 23:54:25 -0400
Received: by pbbrr13 with SMTP id rr13so8588901pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 20:54:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20120828T054548-835@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Aug 28, 2012 at 03:48:49AM +0000, ramu eppa wrote:
> The apache2 error log is,
> 
> radosgw: must specify 'rgw socket path' to run as a daemon
> [Tue Aug 28 08:59:10 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 

As the error log says, you need to specify 'rgw socket path' in your
ceph.conf file. See the man page for an example:

http://ceph.com/docs/master/man/8/radosgw/

Something like this should work:

    rgw socket path = /tmp/radosgw.sock

And in your Apache httpd.conf:

    FastCgiExternalServer /var/www/s3gw.fcgi -socket /tmp/radosgw.sock
