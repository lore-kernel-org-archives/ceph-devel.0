From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Running Test Scripts without CMake Environment Variables
Date: Tue, 19 Apr 2016 19:57:16 +0200
Message-ID: <5716717C.8000900@digiware.nl>
References: <545596550.14429240.1461016414390.JavaMail.zimbra@redhat.com>
 <5715E72A.2040202@digiware.nl>
 <1402915173.14974375.1461074347967.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:19032 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbcDSR53 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Apr 2016 13:57:29 -0400
In-Reply-To: <1402915173.14974375.1461074347967.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ali Maredia <amaredia@redhat.com>, ceph-devel@vger.kernel.org

On 19-4-2016 15:59, Matt Benjamin wrote:
> Hi Willem,
> 
> What are the main barriers to using CMake on FreeBSD?  My only data
> point about it is nfs-ganesha builds, but my understanding has been,
> it's worked for that for a few years.

Hi Matt,

To name a few:

I did not understand that Cmake was the direction of Ceph when I started
last November...

When I started porting I got a few error messages from Cmake. And given
the fact that I'm more familiar with (g)make and autobuild, I chose that
route. I know Cmake exists, and that is about it. So that is again a
tool/language to learn. Autobuild is also far from perfect, but whacking
at it is relatively easy.

It seemed to know little about Clang, if I remember correctly, but it is
like 6 months ago.

Before investing "porting"/migrating to another build tool I prefer to
have at least a working testset. So my focus is mostly on that.

So no real practical ones, just a matter of my current choices.

But perhaps I should give it a try again and see what comes of it..

--WjW

> Matt
> 
> ----- Original Message -----
>> From: "Willem Jan Withagen" <wjw@digiware.nl> To: "Ali Maredia"
>> <amaredia@redhat.com>, ceph-devel@vger.kernel.org Sent: Tuesday,
>> April 19, 2016 4:07:06 AM Subject: Re: Running Test Scripts without
>> CMake Environment Variables
>> 
>> On 18-4-2016 23:53, Ali Maredia wrote:
>>> Ceph community,
>>> 
>>> Recently certain tests that are run in `make check` (one's that
>>> end in .sh and a handful of others) were changed to remove
>>> relative paths and hard coded directories (".libs" was littered
>>> throughout the codebase).
>>> 
>>> These test scripts pass when you run `make check` because of
>>> preset environment variables in CTest and in src/Makefile.am
>>> (CEPH_BIN, CEPH_ROOT, CEPH_LIB, CEPH_BUILD_DIR, etc.) that are
>>> meant to replace the relative paths from before. However running
>>> these tests by themselves after an autotools build without
>>> setting those variables before hand will result in failures.
>>> 
>>> I understand how these recent changes disrupt developers
>>> workflows and plan on issuing a fix that defines those
>>> environment variables according to which build system you build
>>> with ASAP.
>>> 
>>> Finally I strongly encourage developers to transition to using
>>> CMake and CTest (run ctest -V -R {test_name} from
>>> CMAKE_BINARY_DIR), and submit fixes and other contributions.
>> 
>> Hi Ali,
>> 
>> I'm trying to get a port for FreeBSD working, and started from
>> make(gmake) because Cmake did not work that well when I started. 
>> And as such I do always follow the regular pattern and just use
>> the makefiles as they are. Just because running Make at the top
>> level is a rather long process. So I keep a script where I run the
>> tests that are still giving me faults. And it does complete
>> different things from what make does. Because make assuems that
>> things are going to complete with success, but in my case I'm
>> actually expecting things to go wrong. :) So then I start
>> collecting cores and logfiles for post-mortum analysis.
>> 
>> So I'd like to be able to run every test on its own. And even when
>> I would migrate to Cmake, I would still want to be able to do
>> that. So they even have to work if you do not use a build system,
>> it would be very nice if things are backwards compatible.
>> 
>> And yes, I also want to go to Cmake, because autobuild it an odd
>> bucket of bits, but preferably not right now.
>> 
>> Thanx, --WjW -- To unsubscribe from this list: send the line
>> "unsubscribe ceph-devel" in the body of a message to
>> majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>> 
> 

