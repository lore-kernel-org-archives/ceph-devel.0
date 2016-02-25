From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: vstart and Python bindings
Date: Thu, 25 Feb 2016 12:20:35 +0100
Message-ID: <56CEE383.60409@digiware.nl>
References: <20160224233718.6a8c7569@lembas.zaitcev.lan>
 <56CEA76D.9040200@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:31656 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760521AbcBYLUv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Feb 2016 06:20:51 -0500
In-Reply-To: <56CEA76D.9040200@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Pete Zaitcev <zaitcev@redhat.com>, ceph-devel@vger.kernel.org

On 25-2-2016 08:04, Loic Dachary wrote:
> Hi Pete,
> 
> You need https://github.com/ceph/ceph/pull/7792 which is going to be merged real soon now ;-)
> 

I had a similar experience, but that was more due to Makefile.am in pybind:
if ENABLE_CLIENT
if WITH_RADOS
if WITH_RBD
if WITH_CYTHON

PY_DISTUTILS = \
        CPPFLAGS="-iquote \${abs_srcdir}/include ${AM_CPPFLAGS}
${CPPFLAGS}" \
        CFLAGS="-iquote \${abs_srcdir}/include ${AM_CFLAGS} ${CFLAGS}" \
        LDFLAGS="-L\${abs_builddir}/.libs $(subst -pie,,${AM_LDFLAGS})
${LDFLAGS}" \
        CYTHON_BUILD_DIR="$(shell readlink -f $(builddir))/build" \
        ${PYTHON} ./setup.py

include pybind/rbd/Makefile.am
include pybind/rados/Makefile.am

endif
endif
endif
endif

And since I'm not there for RBD, pybind/rados/Makefile.am does not get
included.
So I've reorganised the Makefile, put the WITH_{RADOS,RBD} as most inter
tests, and only with the includes.
But haven't gotten around actually compiling a full set again to see if
rados things are actually made.

--WjW


> Cheers
> 
> On 25/02/2016 13:37, Pete Zaitcev wrote:
>> I did a git pull today and rebuilt. Ran vstart, and it produced a
>> Python traceback, ending with:
>>
>> ImportError: No module named rados
>>
>> Oooookay... This box never had Python bindings installed, but okay,
>> someone innovated something. Fine, I thought. Installed python-rados,
>> and ./ceph -w tracebacks:
>>
>> Traceback (most recent call last):
>>   File "./ceph", line 953, in <module>
>>     retval = main()
>>   File "./ceph", line 778, in main
>>     run_in_thread(cluster_handle.monitor_log, level, watch_cb, 0)
>> AttributeError: 'Rados' object has no attribute 'monitor_log'
>>
>> Of course. The system version of pybind is obsolete, but ./ceph gets
>> wrong one. Actually, it's not even getting built from .pyx anymore.
>>
>> Could whoever did all this please undo?
>>
>> -- Pete
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

