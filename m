From: Wido den Hollander <wido@widodh.nl>
Subject: Re: First work on RBD storage pool support in libvirt
Date: Fri, 02 Mar 2012 16:30:46 +0100
Message-ID: <4F50E7A6.10100@widodh.nl>
References: <4F04A8C1.1090205@widodh.nl> <4F04EFA1.5050704@dreamhost.com> <4F05B8F0.10003@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51550 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030227Ab2CBPav (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 10:30:51 -0500
In-Reply-To: <4F05B8F0.10003@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 01/05/2012 03:51 PM, Wido den Hollander wrote:
> On 01/05/2012 01:32 AM, Josh Durgin wrote:
>> On 01/04/2012 11:30 AM, Wido den Hollander wrote:
>>> Hi,
>>>
>>> The last few days I've been working on a storage backend driver for
>>> libvirt which supports RBD.
>>>
>>> This has been in the tracker for a while:
>>> http://tracker.newdream.net/issues/1422
>>>
>>> My current work can be found at: http://www.widodh.nl/git/libvirt.git in
>>> the 'rbd' branch.
>>
>> Awesome! Glad to see this being worked on.
>>
>>> I realize it is far from done, a lot of work has to be done, but I'd
>>> like to discuss some things first before making some decisions I might
>>> later regret.
>>>
>>> My idea was to discuss it here first and after a few iterations get it
>>> reviewed by the libvirt guys.
>>>
>>> Let me start with the XML:
>>>
>>> <pool type='rbd'>
>>> <name>cephclusterdev</name>
>>> <source>
>>> <name>myrbdpool</name>
>>> <host name='[2a00:f10:11b:cef0:230:48ff:fed3:b086]' port='6789'
>>> prefer_ipv6='true'/>
>>> <auth type='cephx' id='admin'
>>> secret='a313871d-864a-423c-9765-5374707565e1'/>
>>> </source>
>>> </pool>
>>>
>>
>> I think it will be easier to manage if the format for network volumes
>> and network disks are as similar as possible. In particular, allowing
>> multiple hosts, and making the auth element match the network disk
>> format (even using the same xml schema). With this in mind, the format
>> would be more like:
>>
>> <pool type='rbd'>
>> <name>cephclusterdev</name>
>> <source name='myrbdpool'>
>> <host name='[2a00:f10:11b:cef0:230:48ff:fed3:b086]' port='6789'/>
>> <host name='[2a00:f10:11b:cef0:230:48ff:fed3:b086]' port='6790'/>
>> <host name='foo.example.org' port='6789'/>
>> </source>
>> <auth username='admin'>
>> <secret type='ceph' uuid='a313871d-864a-423c-9765-5374707565e1'/>
>> </auth>
>> </pool>
>>
>> Or the secret could be identified by name:
>>
>> <pool type='rbd'>
>> <name>cephclusterdev</name>
>> <source name='myrbdpool'>
>> <host name='[2a00:f10:11b:cef0:230:48ff:fed3:b086]' port='6789'/>
>> <host name='[2a00:f10:11b:cef0:230:48ff:fed3:b086]' port='6790'/>
>> <host name='foo.example.org' port='6789'/>
>> </source>
>> <auth username='admin'>
>> <secret type='ceph' usage='mysecretname'/>
>> </auth>
>> </pool>

I've been doing some work on this, but I'm limited to what libvirt 
offers rights now and I don't want to break anything.

The current XML:

<pool type='rbd'>
   <name>ceph</name>
   <source>
     <name>rbd</name>
     <host name='[2a00:f10:11b:cef0:230:48ff:fed3:b086]' port='6789'/>
     <host name='[2a00:f10:11a:408::1]' port='6789'/>
     <host name='[2a00:f10:11a:409::1]' port='6789'/>
     <auth username='admin' type='ceph'>
	<secret uuid='a313871d-864a-423c-9765-5374707565e1'/>
     </auth>
   </source>
</pool>

This works just fine.

libvirt relies on the type attribute of the auth node for determining 
the auth type:

     authType = virXPathString("string(./auth/@type)", ctxt);
     if (authType == NULL) {
         source->authType = VIR_STORAGE_POOL_AUTH_NONE;
     } else {
         if (STREQ(authType, "chap")) {
             source->authType = VIR_STORAGE_POOL_AUTH_CHAP;
         } else if (STREQ(authType, "ceph")) {
             source->authType = VIR_STORAGE_POOL_AUTH_CEPHX;
         } else {
             virStorageReportError(VIR_ERR_XML_ERROR,
                                   _("unknown auth type '%s'"),
                                   (const char *)authType);
             goto cleanup;
         }
     }

I've tested this code over and over and keeps working.

There is still some work to do:

root@stack01:~# virsh vol-dumpxml rbd/alpha
<volume>
   <name>bigmofo-data</name>
   <key>rbd/bigmofo-data</key>
   <source>
   </source>
   <capacity>4398046511104</capacity>
   <allocation>4398046511104</allocation>
   <target>
     <path>rbd:rbd/alpha</path>
     <format type='unknown'/>
     <permissions>
       <mode>00</mode>
       <owner>0</owner>
       <group>0</group>
     </permissions>
   </target>
</volume>

root@stack01:~#

The 'source' node here should be filled with the right 'host' nodes, but 
that is code that doesn't exist yet in libvirt. It will require some 
extra work in libvirt.

Then there is still the way of passing options down to librados.

For example debugging, a user might want to set 'log file' and 'debug 
rados' so he can debug all the RADOS request which are being made.

It would be helpful if somebody could start reviewing the code. In a 
couple of weeks we can do a proposal at the libvirt guys, but before 
that the code should be reviewed.

Code can be found at: http://www.widodh.nl/git/libvirt.git

The branch rbd is where you should be looking.

Thanks,

Wido

>
> I'm currently using the already existing structure, for example a iSCSI
> pool:
>
> <pool type='iscsi'>
> <name>virtimages</name>
> <uuid>e9392370-2917-565e-692b-d057f46512d6</uuid>
> <source>
> <host name="iscsi.example.com"/>
> <device path="demo-target"/>
> <auth type='chap' login='foobar' passwd='frobbar'/>
> </source>
> <target>
> <path>/dev/disk/by-path</path>
> <permissions>
> <mode>0700</mode>
> <owner>0</owner>
> <group>0</group>
> </permissions>
> </target>
> </pool>
>
> This was the easiest way to get things up and running, but I do agree
> that matching the disk declaration would be preferable.
>
>>
>>> A few things here:
>>>
>>> * I'm leaning on the secretDriver from libvirt for storing the actual
>>> cephx key. Should I also store the id in there or keep that in the pool
>>> declaration?
>>
>> I'd say keep it in the pool declaration for consistency.
>>
>>>
>>> * prefer_ipv6? I'm a IPv6 guy, I try to get as much over IPv6 as I can.
>>> Since Ceph doesn't support dual-stack you have to explicitly enable
>>> IPv6. I did not want to let librados read a ceph.conf from outside
>>> libvirt I added this variable. Not the fanciest way I think, but it
>>> could serve other future storage drivers in libvirt
>>
>> This actually isn't necessary for RBD - the ms_bind_ipv6 option only
>> affects servers (who call bind(2)).
>
> Ah, ok. I'll remove that!
>
>>
>>> * How should we pass other configuration options? I want to stay away
>>> from the ceph.conf as far as possible. Imho a user should be able to
>>> define a XML and get it all up and running. You will also run into
>>> apparmor/SELinux on systems, so libvirt won't have permission to read
>>> files everywhere you want it to. I also thinks the libvirt guys want to
>>> keep everything as generic as possible.
>>
>> I agree, libvirt should be able to configure everything with no external
>> files.
>>
>>> In the future we might see more
>>> storage backends which have almost the same properties as RBD. How do we
>>> pass extra config options? the volume
>>
>> The libvirt way seems to be adding more well-defined elements or
>> attributes to the xml schema when the new backend is added. Personally
>> I'd be happy with a generic <option>:<value> mapping, but I don't think
>> libvirt devs would like that. But this doesn't really matter for the
>> pool implementation - all the info we need to connect is well-defined in
>> the disk xml.
>
> I'll leave that for now, the hostname + port and id + secret should be
> sufficient.
>
>>
>>> That's the XML file for declaring the pool.
>>>
>>> The pool itself uses librados/librbd instead of invoking the 'rbd'
>>> command.
>>>
>>> The other storage backends do invoke external binaries, but that didn't
>>> seem the right way here since we have the luxury of C-API's.
>>>
>>> I'm aware of the fact that a lot of memory handling and cleaning won't
>>> be as it should be. I'm fairly new to C, so I'll make mistakes here and
>>> there.
>>>
>>> The current driver is however focused on Qemu/KVM, since that is
>>> currently the only virtualization technique which supports RBD.
>>>
>>> This exposes another problem. Then you do a "dumpxml" it expects a
>>> target path which is up until now an absolute path to a file or block
>>> device.
>>>
>>> Recently disks with the type 'network' were introduced for Sheepdog and
>>> RBD, but attaching a 'network' volume to a domain is currently not
>>> possible with the XML schemes. I'm thinking about a generic way to
>>> attach network volumes to a domain.
>>
>> It seems like RBD will need to provide the full information (image,
>> hosts, and username/secret) to be able to attach a volume. Maybe this
>> should go in the volume xml? The libvirt devs probably have a good idea
>> of the right approach here. It looks like programs using libvirt will
>> have to adjust for this, but libvirt itself doesn't know how to attach a
>> volume to a guest.
>
> You are right. I thought there was a way in libvirt to directly attach a
> volume to a guest, but this has to be done 'manually'.
>
> The XML dump generated should then be as generic as possible to match
> any other future network storage pools.
>
>>
>>> Another feature I'd like to add in the future is managing kernel RBD. We
>>> could set up RBD for the user and mapping and unmapping devices on
>>> demand for virtual machines.
>>>
>>> The 'rbd' binary does this mapping, but that is done in the binary
>>> itself and not by librbd. Would it be a smart move to add a map() and
>>> unmap() method to librbd?
>>
>> I'm not sure this should go in librbd - I'd rather make the 'rbd' binary
>> more usable for mapping/unmapping without any ceph.conf.
>
> That is something I want to implement at a later stadium. But I think it
> would be a smart move to have this all done before submitting to
> libvirt, otherwise we'll get a situation where some functionality is
> missing with users.
>
>>
>>> The last thing I'm thinking about is the spare allocation of the RBD
>>> images. Right now both 'allocation' and 'capacity' are set to the
>>> virtual size of the RBD image. rbd_stat() does not report the actual
>>> size of the image, it only reports the virtual size of the image. Is
>>> there a way to figure out how big a RBD image actually is?
>>
>> There's no way to do this efficiently right now. It is possible to add
>> an allocation bitmap, and we might as an optimization for layering, but
>> that's farther down the road.
>
> Ok.
>
> Wido
>
>>
>>>
>>>
>>> My plan is to add RBD support to CloudStack after the libvirt
>>> integration has finished. CloudStack heavily relies on the storage pools
>>> of libvirt, so adding RBD support to CloudStack depends on libvirt.
>>>
>>> Feedback is welcome on this!
>>>
>>> Thanks,
>>>
>>> Wido
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

