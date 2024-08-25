#include "friendnode.h"

FriendNode::FriendNode()
    :no{-1},isFriend{false},connectivity{-3}
{
}

FriendNode::FriendNode(const long long number)
    :no{number},isFriend{false},connectivity(-1)
{

}

FriendNode::FriendNode(const long long number, const bool isF, const long long connect)
    :no{number},isFriend{isF},connectivity{connect}
{

}
