From: James Page <james.page@ubuntu.com>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Thu, 04 Oct 2012 21:24:59 +0100
Message-ID: <506DF09B.20505@ubuntu.com>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com> <alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net> <CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com> <CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com> <alpine.DEB.2.00.1210031238300.23173@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54994 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab2JDUZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Oct 2012 16:25:06 -0400
In-Reply-To: <alpine.DEB.2.00.1210031238300.23173@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: gcs@debian.hu, Noah Watkins <jayhawk@cs.ucsc.edu>, Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/10/12 20:39, Sage Weil wrote:
> On Wed, 3 Oct 2012, Noah Watkins wrote:
>>> Hi Sage,
>>> 
>>> I wanted to touch base on this Java bindings patch series to
>>> make sure this can become a solid foundation for the Hadoop
>>> shim clean-up. Were there any specific issues with this, other
>>> than not yet having a major consumer?
> From my perspective it's ready.  I was hoping that Laszlo could
> look at the packaging bits before I merged, but then I lost track
> of it.
> 
> Laszlo, do you have a minute to take a look?

Laszlo - hope you don't mind me jumping in but Java packaging is
something I have quite a bit of experience with.

A few bits of feedback:

1) Split of Java bytecode and native JNI code

Inline with
http://www.debian.org/doc/packaging-manuals/java-policy/x104.html, the
native JNI code should be in a separate, arch-specific, package to the
Java bytecode (which ideally should be arch: all).

  libceph-java Depends -> libceph-jni

The only reason I could think of to not do this would be to exclude
architectures in Debian for which ceph does not build from having a
Java arch: all package which is un-installable.

2) libceph1-java naming

As ceph is the only source package likely to produce this code the
version is really not required as this is simply to prevent conflicts
when multiple versions of a Java library are required - libceph-java
is just fine.

3) jar files in /usr/share/java

Java policy dictates a versioned and unversioned jar in /usr/share/java:

/usr/share/java/ceph-0.48.2.jar
/usr/share/java/ceph.jar -> ceph-0.48.2.jar

Tools such as javahelper can do this for you - which I see on the BD's.

Use debian/libceph-java.jlibs + plumb jh_installlibs into debian/rules
and javahelper will do this for you.

4) src/java/build.xml

Please set the source/target version of Java to something sensible
during the build process - ideally 1.5 (as 1.6 introduced no new
language features).  Ubuntu quantal's default-jdk is OpenJDK7 -
without this it will build code which is not backwards compatible.

And openjdk-6/oracle java 6 is still available...

HTH

Cheers

James

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBCAAGBQJQbfCbAAoJEL/srsug59jDt0AP/RNkUopLnHuumgyfvaqoH3EI
1FYGlwBb4x5KqaBF0gfzSOl4TlLtQlNUMjScsIaFQmIzVuQxyj/JrtmSyLO1nAu2
udNg0kBFErYbf6oxvJPo3bFBqsRzIQnpLtjjLXl39h83Iw7YhNnxwORD8C7ofrBG
yzt3ugXE5lmJYb/TPWompJZiVKi2G7XXJuO3psv4Qp4I0DKwjNQc0nHK1EA7vwFB
eMyVCzK0kfvNSpoLI3/N9U7k3Hpgx0i72pKNzF0aZj13dqJx8WXgbfoXRSmd68Ut
4Ao/UWsxHakYs6DwvHY5MD9OZuLbLtfey9nNi+sciEdolq4tO9Halpu4sUJlCrQg
iGDq8SF+yg2oulM09rxbUBhs9hU7DdPFPNibH7M7nsRKjI8SVAoT8RVtzY9kAZOd
x0GluRa++IsRwyw2I9xYvcHVg0+TeMHEsGeNOHQ9OjfSXWIG45J9htL3BE8w6vXp
PsLRerW/k6DDXffKL9EJSstsJ5oRc3T/FMmnswB8eEugZ/4hKoE9lWwFqkwJp/WV
7HB7DlC9JEMNCf4Wvr7RYQs8JcSh94ERq0LCX2L/BWjwHdqUU8votrKGnHbjBA/o
N1eK++qVqdKRc6CyauYuo33VsR6wrCyo5GZeUiH389nJ/P+ov+v7T7dFrcqzLyaP
PCRKRQ09ADFakFOVx+Qv
=ZkNY
-----END PGP SIGNATURE-----
