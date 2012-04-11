From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 11:22:26 -0700
Message-ID: <4D23FD899165483BAF0CEEDC9FF75D61@dreamhost.com>
References: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64517 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089Ab2DKSW3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 14:22:29 -0400
Received: by obbtb18 with SMTP id tb18so1541390obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 11:22:29 -0700 (PDT)
In-Reply-To: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Wednesday, April 11, 2012 at 11:12 AM, Noah Watkins wrote:
> Hi all,
> 
> A simple program like this:
> 
> int main(int argc, char **argv)
> {
> int ret;
> struct ceph_mount_info *cmount;
> 
> ceph_create(&cmount, NULL);
> //ceph_mount(cmount, NULL);
> ceph_chdir(cmount, "/");
> }
> 
> will segfault because in the below snippet, cmount->get_client() returns NULL when ceph_mount(..) has not been been called with success.
> 
> extern "C" int ceph_chdir (struct ceph_mount_info *cmount, const char *s) 
> { 
> return cmount->get_client()->chdir(s); 
> }
> 
> It would be very useful to get a uniform error return value rather than the fault. Something like this came to mind:
> 
> diff --git a/src/libcephfs.cc (http://libcephfs.cc) b/src/libcephfs.cc (http://libcephfs.cc)
> index b1481e6..4751e8f 100644
> --- a/src/libcephfs.cc (http://libcephfs.cc)
> +++ b/src/libcephfs.cc (http://libcephfs.cc)
> @@ -180,6 +180,10 @@ public:
> return cct;
> }
> 
> + bool is_mounted(void) {
> + return mounted;
> + }
> +
> private:
> uint64_t msgr_nonce;
> bool mounted;
> @@ -282,6 +286,8 @@ extern "C" const char* ceph_getcwd(struct ceph_mount_info *cmount)
> 
> extern "C" int ceph_chdir (struct ceph_mount_info *cmount, const char *s)
> {
> + if (!cmount->is_mounted())
> + return -1004;
> return cmount->get_client()->chdir(s);
> }
> 
> Any thoughts on a good way to handle this?
> 
> -Noah 
I'm not sure where the "-1004" came from, but I've been doing things very much like this in my code recently. Functions that require simple preconditions (well, really any preconditions) like that should document them, have defined behavior if they're not met, and return defined error codes. I believe our new code does, but <insert legacy code excuse>. 

Patches welcome, of course, but if it's still a problem this summer we can probably put an intern on it for a day to help them understand why standard programming practices are good things. ;)

-Greg
