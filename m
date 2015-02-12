From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: using radosgw with mod_proxy_fcgi
Date: Thu, 12 Feb 2015 18:21:08 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF915554BCEC@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF915554B70A@SATLEXDAG01.amd.com>
 <54DCEBF7.9080708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:33917
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750881AbbBLSVV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 13:21:21 -0500
In-Reply-To: <54DCEBF7.9080708@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ken --

I am running httpd-2.4.10-9

I was able to get a conf set up to do a ProxyPass to a PHP-FPM with this command
   ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://127.0.0.1:9000/var/www/mysite/$1

and that worked. (executing a phpinfo() script showed the Fastcgi connection)
I'm still working on the radosgw setup.

By the way, the page that talked about setting things up for the PHP-FPM
also had this Directory record in the conf file.  Do we need anything of that
sort for radosgw?

    <Directory "/var/www/mysite">
      Order allow,deny
      Allow from all
      AllowOverride FileInfo All
      # New directive needed in Apache 2.4.3:
      Require all granted
    </Directory>

-- Tom

-----Original Message-----
From: Ken Dreyer [mailto:kdreyer@redhat.com] 
Sent: Thursday, February 12, 2015 12:08 PM
To: Deneau, Tom; ceph-devel@vger.kernel.org
Subject: Re: using radosgw with mod_proxy_fcgi

On 02/11/2015 05:21 PM, Deneau, Tom wrote:
> I am running on a platform (aarch64) for which there are no pre-built 
> binaries of the ceph patched apache and the ceph patched mod_fastcgi.

Hi Tom,

The ceph-patched Apache had numerous outstanding CVEs, and I discourage users from running it any more. The distro-supplied Apache should be suitable. We're still working to update our docs regarding this.

What distribution are you running on aarch64, by the way? Dan or I are probably the ones who are going to be packaging mod_proxy_fcgi for Apache 2.2, so I'm curious to know what users are running.

- Ken
