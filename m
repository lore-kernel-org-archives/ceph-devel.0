From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Mon, 16 Jul 2012 08:49:49 -0700
Message-ID: <CAPrxi5-2STepCif9aN1GyfTwFEzs56o5Nzg7NuHmBqq=7qWVEQ@mail.gmail.com>
References: <loom.20120712T065146-882@post.gmane.org>
	<CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com>
	<loom.20120712T111906-426@post.gmane.org>
	<CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com>
	<loom.20120713T085715-195@post.gmane.org>
	<CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com>
	<loom.20120716T061714-349@post.gmane.org>
	<C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu>
	<loom.20120716T072848-760@post.gmane.org>
	<CAPrxi5-dB2_P71zNzvE9hx-zXaC2wtm_KpQ=bA8QaE6qzz7JFw@mail.gmail.com>
	<alpine.DEB.2.00.1207160824220.9848@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:63952 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2GPPtu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 11:49:50 -0400
Received: by ghrr11 with SMTP id r11so5127930ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 08:49:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207160824220.9848@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ramu <ramu.freesystems@gmail.com>, ceph-devel@vger.kernel.org

On Mon, Jul 16, 2012 at 8:26 AM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 16 Jul 2012, Noah Watkins wrote:
>> Ramu,
>>
>> I receive the same error code in my installation when the
>> CEPH_CONF_FILE environment variable contains an invalid path. Could
>> you please verify that the path you are using points to a valid Ceph
>> configuration?
>
> BTW it's CEPH_CONF for the config file (not CEPH_CONFG_FILE).

It turns out to be quite awkward to tell the unit tests about the
configuration location, and using an environment variable is
convenient. However, I wasn't aware of CEPH_CONF, and in fact the unit
test framework looks for CEPH_CONFIG_FILE. The later should definitely
be removed (ramu, can you try CEPH_CONF?), and this isn't an issue in
libcephfs wrappers -- the rados wrappers are incredibly old.

Thanks, Noah


>
> Alternatively, you can stick config options in the same format as the
> command line arguments in CEPH_ARGS.  E.g.,
>
>         CEPH_ARGS="--debug-ms 1 --log-file foo" some_command ...
>
> sage
>
>
>>
>> Thanks,
>> - Noah
>>
>> On Sun, Jul 15, 2012 at 10:32 PM, ramu <ramu.freesystems@gmail.com> wrote:
>> >
>> > Hi Noah,
>> >
>> > I tried but am getting following error in terminal ,
>> >
>> > Buildfile: /home/vu/java-rados/build.xml
>> >
>> > makedir:
>> >
>> > compile-rados:
>> >
>> > compile-tests:
>> >
>> > jar:
>> >
>> > test:
>> >     [junit] Running ClusterStatsTest
>> >     [junit] Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.04 sec
>> >
>> > BUILD FAILED
>> > /home/vu/java-rados/build.xml:134: Test ClusterStatsTest failed
>> >
>> > Total time: 1 second
>> >
>> > and one more error file
>> > is /home/vu/java-rados/TEST-ClusterStatsTest.txt in that file the text is like
>> > this,
>> >
>> > Testsuite: ClusterStatsTest
>> > Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.04 sec
>> >
>> > Testcase: test_ClusterStats took 0.022 sec
>> >         Caused an ERROR
>> > conf_read_file: ret=-22
>> > net.newdream.ceph.rados.RadosException: conf_read_file: ret=-22
>> >         at net.newdream.ceph.rados.Cluster.native_conf_read_file(Native Method)
>> >         at net.newdream.ceph.rados.Cluster.readConfigFile(Unknown Source)
>> >         at ClusterStatsTest.setup(Unknown Source)
>> >
>> > Thanks,
>> > Ramu.
>> >
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
