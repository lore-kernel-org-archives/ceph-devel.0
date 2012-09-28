From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: RPMs
Date: Thu, 27 Sep 2012 20:53:14 -0700
Message-ID: <57572E0E-DF08-43DA-AD17-FB740DD910DC@inktank.com>
References: <alpine.DEB.2.00.1209271344000.13352@cobra.newdream.net> <5064BE11.50909@widodh.nl> <CALk=J71ygxP80RcBJKsSEZBOmQcpWsXpcXFMi6t=GBUVfYqPwQ@mail.gmail.com> <alpine.DEB.2.00.1209271405360.13352@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41918 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab2I1DxR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 23:53:17 -0400
Received: by pbbrr4 with SMTP id rr4so4542503pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 20:53:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209271405360.13352@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Marino Pascual <mpascual@heartflow.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

The ceph 0.52 rpm packages have been rebuilt without the libcryptopp dependency.

Let me know if there are any further issues, or suggestions for improvements.

Cheers,
Gary


On Sep 27, 2012, at 2:08 PM, Sage Weil wrote:

> On Thu, 27 Sep 2012, Marino Pascual wrote:
>> Add the EPEL repo and you can find it there.
>> su -c 'rpm -Uvhhttp://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-7.noarch.r
>> pm'
> 
> Gary, we should probably build these with --with-nss --without-cryptopp 
> passed to configure, since libnss3 is in the base distribution and 
> libcrypo++ is not.  That's what we're doing now for debian and ubuntu.
> 
> sage
> 
>> 
>> On Thu, Sep 27, 2012 at 1:58 PM, Wido den Hollander <wido@widodh.nl> wrote:
>>      On 09/27/2012 10:47 PM, Sage Weil wrote:
>>            For v0.52 we built some RPMs for the first time.
>>             The release machinery
>>            here is brand new (thanks, Gary!), so if you run
>>            into problems (or don't!)
>>            with the repos as they are currently set up, let us
>>            know.
>> 
>> 
>> The link in the docs is dead: ceph.com/docs/master/install/rpm/
>> 
>> su -c ?rpm -Uvh
>> http://ceph.com/rpms/el6/x86_64/ceph-release-1-0.noarch.rpm?
>> 
>> The correct RPM URL is:
>> http://ceph.com/rpms/el6/x86_64/ceph-release-1-0.el6.noarch.rpm
>> 
>> Same goes for the FC17.
>> 
>> After fixing that I tried to install Ceph on CentOS 6.3 with:
>> 
>> $ yum install ceph
>> 
>> That resulted in:
>> 
>> --> Running transaction check
>> ---> Package ceph.x86_64 0:0.52-6.el6 will be installed
>> --> Processing Dependency: libcryptopp.so.6()(64bit) for package:
>> ceph-0.52-6.el6.x86_64
>> ---> Package libcephfs1.x86_64 0:0.52-6.el6 will be installed
>> --> Processing Dependency: libcryptopp.so.6()(64bit) for package:
>> libcephfs1-0.52-6.el6.x86_64
>> ---> Package librados2.x86_64 0:0.52-6.el6 will be installed
>> --> Processing Dependency: libcryptopp.so.6()(64bit) for package:
>> librados2-0.52-6.el6.x86_64
>> ---> Package librbd1.x86_64 0:0.52-6.el6 will be installed
>> --> Processing Dependency: libcryptopp.so.6()(64bit) for package:
>> librbd1-0.52-6.el6.x86_64
>> --> Finished Dependency Resolution
>> Error: Package: libcephfs1-0.52-6.el6.x86_64 (ceph)
>>            Requires: libcryptopp.so.6()(64bit)
>> Error: Package: ceph-0.52-6.el6.x86_64 (ceph)
>>            Requires: libcryptopp.so.6()(64bit)
>> Error: Package: librados2-0.52-6.el6.x86_64 (ceph)
>>            Requires: libcryptopp.so.6()(64bit)
>> Error: Package: librbd1-0.52-6.el6.x86_64 (ceph)
>>            Requires: libcryptopp.so.6()(64bit)
>>  You could try using --skip-broken to work around the problem
>>  You could try running: rpm -Va --nofiles --nodigest
>> 
>> This should be part of the cryptopp package I think? But this package
>> isn't available on my CentOS machine.
>> 
>> Any suggestions?
>> 
>> Wido
>> 
>>      We started with CentOS6/RHEL6 and Fedora 17 for x86_64.
>>       Please let us
>>      know what other distributions/architectures you are
>>      interested in.
>> 
>>      Thanks!
>>      sage
>> 
>>      --
>>      To unsubscribe from this list: send the line "unsubscribe
>>      ceph-devel" in
>>      the body of a message to majordomo@vger.kernel.org
>>      More majordomo info at
>>       http://vger.kernel.org/majordomo-info.html
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
>> 

