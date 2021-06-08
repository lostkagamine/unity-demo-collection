using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class WindowTitleBar : MonoBehaviour, IDragHandler
{
    public void OnDrag(PointerEventData eventData)
    {
        var parent = GetComponentInParent<Window>();
        if (parent == null)
        {
            throw new System.Exception("Cannot find parent in window titlebar! Are you sure this is a window?");
        }
        parent.Move(eventData.delta);
    }
}
