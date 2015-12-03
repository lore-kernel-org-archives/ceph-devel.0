From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: cmake
Date: Thu, 3 Dec 2015 17:31:17 -0500 (EST)
Message-ID: <1398623124.28563022.1449181877807.JavaMail.zimbra@redhat.com>
References: <20151203152436.73e15e38@lembas.zaitcev.lan> <153715043.28562710.1449181828218.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:58706 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbLCWbS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 17:31:18 -0500
In-Reply-To: <153715043.28562710.1449181828218.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: ceph-devel@vger.kernel.org

sorry, "cmake .." for Ceph's setup.

Matt

----- Original Message -----
> From: "Matt Benjamin" <mbenjamin@redhat.com>
> To: "Pete Zaitcev" <zaitcev@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Thursday, December 3, 2015 5:30:28 PM
> Subject: Re: cmake
> 
> I always run cmake from a build directory which is not the root, usually
> "build" in the root, so my minimal invocation would be "mkdir build; cd
> build; cmake ../src"--I'd at least try that, though I wouldn't have thought
> build location could affect something this basic (and it would be a bug).
> 
> Matt
> 
> ----- Original Message -----
> > From: "Pete Zaitcev" <zaitcev@redhat.com>
> > To: ceph-devel@vger.kernel.org
> > Sent: Thursday, December 3, 2015 5:24:36 PM
> > Subject: cmake
> > 
> > Dear All:
> > 
> > I'm trying to run cmake, in order to make sure my patches do not break it
> > (in particular WIP 5073 added source files). Result looks like this:
> > 
> > [zaitcev@lembas ceph-tip]$ cmake src
> > -- The C compiler identification is GNU 5.1.1
> > -- The CXX compiler identification is GNU 5.1.1
> > -- Check for working C compiler: /usr/bin/cc
> > -- Check for working C compiler: /usr/bin/cc -- works
> > -- Detecting C compiler ABI info
> > -- Detecting C compiler ABI info - done
> > -- Detecting C compile features
> > -- Detecting C compile features - done
> > -- Check for working CXX compiler: /usr/bin/c++
> > -- Check for working CXX compiler: /usr/bin/c++ -- works
> > -- Detecting CXX compiler ABI info
> > -- Detecting CXX compiler ABI info - done
> > -- Detecting CXX compile features
> > -- Detecting CXX compile features - done
> > CMake Error at CMakeLists.txt:1 (include):
> >   include could not find load file:
> > 
> >     GetGitRevisionDescription
> > 
> > 
> > -- The ASM compiler identification is GNU
> > -- Found assembler: /usr/bin/cc
> > CMake Warning (dev) at CMakeLists.txt:11 (add_definitions):
> >   Policy CMP0005 is not set: Preprocessor definition values are now escaped
> >   automatically.  Run "cmake --help-policy CMP0005" for policy details.
> >   Use
> >   the cmake_policy command to set the policy and suppress this warning.
> > This warning is for project developers.  Use -Wno-dev to suppress it.
> > 
> > CMake Warning (dev) at CMakeLists.txt:12 (add_definitions):
> >   Policy CMP0005 is not set: Preprocessor definition values are now escaped
> >   automatically.  Run "cmake --help-policy CMP0005" for policy details.
> >   Use
> >   the cmake_policy command to set the policy and suppress this warning.
> > This warning is for project developers.  Use -Wno-dev to suppress it.
> > 
> > --  we do not have a modern/working yasm
> > -- Performing Test COMPILER_SUPPORTS_CXX11
> > -- Performing Test COMPILER_SUPPORTS_CXX11 - Success
> > CMake Error at CMakeLists.txt:95 (get_git_head_revision):
> >   Unknown CMake command "get_git_head_revision".
> > 
> > 
> > CMake Warning (dev) in CMakeLists.txt:
> >   No cmake_minimum_required command is present.  A line of code such as
> > 
> >     cmake_minimum_required(VERSION 3.3)
> > 
> >   should be added at the top of the file.  The version specified may be
> >   lower
> >   if you wish to support older CMake versions for this project.  For more
> >   information run "cmake --help-policy CMP0000".
> > This warning is for project developers.  Use -Wno-dev to suppress it.
> > 
> > -- Configuring incomplete, errors occurred!
> > See also "/q/zaitcev/ceph/ceph-tip/CMakeFiles/CMakeOutput.log".
> > [zaitcev@lembas ceph-tip]$ rpm -qa | grep -i cmake
> > extra-cmake-modules-5.16.0-1.fc23.noarch
> > cmake-3.3.2-1.fc23.x86_64
> > [zaitcev@lembas ceph-tip]$
> > 
> > Is this expected? Is my cmake incantation wrong?
> > 
> > Thanks,
> > -- Pete
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
> 
> http://www.redhat.com/en/technologies/storage
> 
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
