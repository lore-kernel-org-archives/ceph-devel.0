From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cmake
Date: Thu, 17 Dec 2015 00:47:48 +0100
Message-ID: <5671F824.3070408@digiware.nl>
References: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
 <CADRKj5Ru75B=uNtb3OyaBBxYJVLrNXPhec77pnQddj88Jb05ng@mail.gmail.com>
 <1306047444.39980907.1450292766855.JavaMail.zimbra@redhat.com>
 <alpine.DEB.2.00.1512161136490.10312@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:46008 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755302AbbLPXr7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Dec 2015 18:47:59 -0500
In-Reply-To: <alpine.DEB.2.00.1512161136490.10312@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 16-12-2015 20:38, Sage Weil wrote:
> On Wed, 16 Dec 2015, Matt Benjamin wrote:
>> I'm going to push for cmake work already in progress to be moved to the 
>> next milestone ASAP.
>>
>> With respect to "make check" blockers, which contains the issue of where 
>> cmake puts built objects.  Ali, Casey, and I discussed this today at 
>> some length.  We think the current "hackery" to make cmake make check 
>> work "the same way" auto* did is long-term undesirable due to it 
>> mutating files in the src dir.  I have not assumed that it would be an 
>> improvement to put all objects built in a tree of submakes into a single 
>> dir, as automake does.  I do think it is essential that at least 
>> eventually, it makes it simple to operate on any object that is built, 
>> and simple to extend processes like make check.
> 
> All of the binaries eventually go into /usr[/local]/bin anyway.  Can we 
> do the same here?  (I don't care where intermediate .lo or .o objects 
> go...)

Why not take it one step further and have something like:
	..../ceph/build/{bin,sbin,lib,libexec,etc,tmp,test,log,.....}

which would be separate tree part where all the stuff is build.
Cleaning up will then also become a lot easier.... ATM the stuff in .lib
is not cleaned, I think.
It would also allow to process scripts to fit the local OS by running it
thru m4/sed/awk/perl/...

Or if you prefer so, hang it of ..../ceph/src

But then again this might require something like: make install-build

--WjW

